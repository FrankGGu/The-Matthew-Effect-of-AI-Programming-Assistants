package main

import (
	"fmt"
	"sort"
)

type Point struct {
	x, y int
}

func minRectangles(points [][]int) int {
	if len(points) == 0 {
		return 0
	}

	pointMap := make(map[Point]struct{})
	for _, p := range points {
		pointMap[Point{p[0], p[1]}] = struct{}{}
	}

	rectCount := 0

	for p := range pointMap {
		if _, ok := pointMap[p]; !ok {
			continue
		}
		rectCount++
		delete(pointMap, p)

		for p1 := range pointMap {
			if _, ok := pointMap[p1]; !ok {
				continue
			}
			if p1.x > p.x && p1.y > p.y {
				delete(pointMap, p1)
			}
		}

		for p2 := range pointMap {
			if _, ok := pointMap[p2]; !ok {
				continue
			}
			if p2.x < p.x && p2.y < p.y {
				delete(pointMap, p2)
			}
		}
	}

	return rectCount
}

func main() {
	points := [][]int{{1, 2}, {2, 1}, {1, 1}, {2, 2}, {3, 3}}
	fmt.Println(minRectangles(points))
}