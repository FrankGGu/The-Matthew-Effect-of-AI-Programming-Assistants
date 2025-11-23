package main

import "math"

func checkOverlap(radius int, xCenter int, yCenter int, x1 int, y1 int, x2 int, y2 int) bool {
	closestX := float64(xCenter)
	closestY := float64(yCenter)

	if xCenter < x1 {
		closestX = float64(x1)
	} else if xCenter > x2 {
		closestX = float64(x2)
	}

	if yCenter < y1 {
		closestY = float64(y1)
	} else if yCenter > y2 {
		closestY = float64(y2)
	}

	distX := float64(xCenter) - closestX
	distY := float64(yCenter) - closestY

	distanceSquared := (distX * distX) + (distY * distY)

	return distanceSquared <= float64(radius*radius)
}