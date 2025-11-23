package main

import (
	"math"
	"sort"
)

type Point struct {
	x, y float64
}

func visiblePoints(points [][]int, angle int, location []int) int {
	origin := Point{float64(location[0]), float64(location[1])}
	var angles []float64
	count := 0

	for _, p := range points {
		if p[0] == location[0] && p[1] == location[1] {
			count++
			continue
		}
		dx := float64(p[0]) - origin.x
		dy := float64(p[1]) - origin.y
		theta := math.Atan2(dy, dx) * 180 / math.Pi
		angles = append(angles, theta)
	}

	sort.Float64s(angles)
	n := len(angles)
	for i := 0; i < n; i++ {
		angles = append(angles, angles[i]+360)
	}

	maxVisible := 0
	angleRad := float64(angle)

	for i, startAngle := range angles[:n] {
		endAngle := startAngle + angleRad
		right := sort.Search(len(angles), func(j int) bool {
			return angles[j] > endAngle
		})
		maxVisible = max(maxVisible, right-i)
	}

	return maxVisible + count
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}