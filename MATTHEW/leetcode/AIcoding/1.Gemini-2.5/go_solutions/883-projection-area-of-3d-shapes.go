package main

import "math"

func projectionArea(grid [][]int) int {
	n := len(grid)
	xyArea := 0
	xzArea := 0
	yzArea := 0

	colMaxes := make([]int, n)

	for i := 0; i < n; i++ {
		rowMax := 0
		for j := 0; j < n; j++ {
			height := grid[i][j]

			// XY-plane projection (top view)
			if height > 0 {
				xyArea++
			}

			// YZ-plane projection (side view, max of each row)
			rowMax = int(math.Max(float64(rowMax), float64(height)))

			// XZ-plane projection (front view, max of each column)
			colMaxes[j] = int(math.Max(float64(colMaxes[j]), float64(height)))
		}
		yzArea += rowMax
	}

	// Sum up the maximums for each column for XZ-plane projection
	for j := 0; j < n; j++ {
		xzArea += colMaxes[j]
	}

	return xyArea + xzArea + yzArea
}