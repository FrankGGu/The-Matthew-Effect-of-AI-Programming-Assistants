package main

import "math"

type Point struct {
	X, Y int
}

func countLatticePoints(circles [][]int) int {
	minX, minY := math.MaxInt32, math.MaxInt32
	maxX, maxY := math.MinInt32, math.MinInt32

	for _, circle := range circles {
		cx, cy, r := circle[0], circle[1], circle[2]
		minX = min(minX, cx-r)
		minY = min(minY, cy-r)
		maxX = max(maxX, cx+r)
		maxY = max(maxY, cy+r)
	}

	visitedPoints := make(map[Point]bool)

	for x := minX; x <= maxX; x++ {
		for y := minY; y <= maxY; y++ {
			for _, circle := range circles {
				cx, cy, r := circle[0], circle[1], circle[2]

				dx := x - cx
				dy := y - cy

				if dx*dx+dy*dy <= r*r {
					visitedPoints[Point{X: x, Y: y}] = true
					break
				}
			}
		}
	}

	return len(visitedPoints)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}