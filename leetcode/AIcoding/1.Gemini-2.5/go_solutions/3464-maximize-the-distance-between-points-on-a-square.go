package main

import "math"

func maxDistance(points [][]int) int {
	if len(points) < 2 {
		return 0
	}

	minX := points[0][0]
	maxX := points[0][0]
	minY := points[0][1]
	maxY := points[0][1]

	for i := 1; i < len(points); i++ {
		x := points[i][0]
		y := points[i][1]

		if x < minX {
			minX = x
		}
		if x > maxX {
			maxX = x
		}
		if y < minY {
			minY = y
		}
		if y > maxY {
			maxY = y
		}
	}

	return int(math.Max(float64(maxX-minX), float64(maxY-minY)))
}