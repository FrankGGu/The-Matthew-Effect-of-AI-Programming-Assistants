package main

import (
	"sort"
)

func maxRectangle(points [][]int) int {
	xs := make([]int, len(points))
	ys := make([]int, len(points))
	for i, p := range points {
		xs[i] = p[0]
		ys[i] = p[1]
	}
	sort.Ints(xs)
	sort.Ints(ys)

	maxArea := 0
	for i := 0; i < len(xs); i++ {
		for j := i + 1; j < len(xs); j++ {
			for k := 0; k < len(ys); k++ {
				for l := k + 1; l < len(ys); l++ {
					if isPointIn(points, xs[i], ys[k]) && isPointIn(points, xs[i], ys[l]) &&
						isPointIn(points, xs[j], ys[k]) && isPointIn(points, xs[j], ys[l]) {
						area := (xs[j] - xs[i]) * (ys[l] - ys[k])
						if area > maxArea {
							maxArea = area
						}
					}
				}
			}
		}
	}
	return maxArea
}

func isPointIn(points [][]int, x int, y int) bool {
	for _, p := range points {
		if p[0] == x && p[1] == y {
			return true
		}
	}
	return false
}