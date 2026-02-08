package main

import (
	"fmt"
	"math"
)

func isRectangleCover(rectangles [][]int) bool {
	if len(rectangles) == 0 {
		return false
	}

	minX, minY := math.MaxInt32, math.MaxInt32
	maxX, maxY := math.MinInt32, math.MinInt32
	var totalArea int64 = 0

	points := make(map[string]struct{})

	for _, rect := range rectangles {
		x1, y1, x2, y2 := rect[0], rect[1], rect[2], rect[3]

		minX = min(minX, x1)
		minY = min(minY, y1)
		maxX = max(maxX, x2)
		maxY = max(maxY, y2)

		totalArea += int64(x2-x1) * int64(y2-y1)

		key1 := fmt.Sprintf("%d,%d", x1, y1)
		if _, ok := points[key1]; ok {
			delete(points, key1)
		} else {
			points[key1] = struct{}{}
		}

		key2 := fmt.Sprintf("%d,%d", x1, y2)
		if _, ok := points[key2]; ok {
			delete(points, key2)
		} else {
			points[key2] = struct{}{}
		}

		key3 := fmt.Sprintf("%d,%d", x2, y1)
		if _, ok := points[key3]; ok {
			delete(points, key3)
		} else {
			points[key3] = struct{}{}
		}

		key4 := fmt.Sprintf("%d,%d", x2, y2)
		if _, ok := points[key4]; ok {
			delete(points, key4)
		} else {
			points[key4] = struct{}{}
		}
	}

	if len(points) != 4 {
		return false
	}

	expectedCorners := []string{
		fmt.Sprintf("%d,%d", minX, minY),
		fmt.Sprintf("%d,%d", minX, maxY),
		fmt.Sprintf("%d,%d", maxX, minY),
		fmt.Sprintf("%d,%d", maxX, maxY),
	}

	for _, cornerKey := range expectedCorners {
		if _, ok := points[cornerKey]; !ok {
			return false
		}
	}

	if totalArea != int64(maxX-minX)*int64(maxY-minY) {
		return false
	}

	return true
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