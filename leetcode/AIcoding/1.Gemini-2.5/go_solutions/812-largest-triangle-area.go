package main

import "math"

func largestTriangleArea(points [][]int) float64 {
	n := len(points)
	maxArea := 0.0

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			for k := j + 1; k < n; k++ {
				p1 := points[i]
				p2 := points[j]
				p3 := points[k]

				x1, y1 := float64(p1[0]), float64(p1[1])
				x2, y2 := float64(p2[0]), float64(p2[1])
				x3, y3 := float64(p3[0]), float64(p3[1])

				area := 0.5 * math.Abs(x1*(y2-y3)+x2*(y3-y1)+x3*(y1-y2))
				if area > maxArea {
					maxArea = area
				}
			}
		}
	}
	return maxArea
}