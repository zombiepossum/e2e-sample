gulp = require 'gulp'
plumber = require 'gulp-plumber'
coffee = require 'gulp-coffee'
cp = require 'child_process'
gutil = require 'gulp-util'
shell = require 'gulp-shell'

coffeeSources = {
	coffee: "src/coffee/**/*.coffee"
}
destinations = {
	build: "lib"
}

testSources = "spec/**/*.coffee"

taskListing = require 'gulp-task-listing'

# Add a task to render the output
gulp.task 'help', taskListing

# BUILD COFFEE
gulp.task 'coffee:build', (event)->
	gulp.src(coffeeSources.coffee)
		.pipe(plumber())
		.pipe(coffee())
		.pipe(gulp.dest(destinations.build))

# WATCH COFFEE
gulp.task 'coffee:watch', (event)->
	gulp.watch coffeeSources.coffee, ["coffee:build"]

# Run Jasmine tests
gulp.task 'jasmine:run', (event)->
	gulp.src('').pipe shell ["./node_modules/jasmine-node/bin/jasmine-node spec --coffee"]

# Watch for changes and run Jasmine
gulp.task 'jasmine:watch', (event)->
	gulp.watch testSources, ["jasmine:run"]
	gulp.watch coffeeSources.coffee, ["jasmine:run"]

# DEV TASK
gulp.task 'dev', ['jasmine:watch', 'coffee:watch']
# DEFAULT TASK
gulp.task 'default', ["dev"]
