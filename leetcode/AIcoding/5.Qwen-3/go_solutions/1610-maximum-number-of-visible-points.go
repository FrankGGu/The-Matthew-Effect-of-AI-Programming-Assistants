package main

import (
	"math"
	"sort"
)

func visiblePoints(points [][]int, angle int, x int, y int) int {
	var polarAngles []float64
	originCount := 0

	for _, p := range points {
		dx := p[0] - x
		dy := p[1] - y
		if dx == 0 && dy == 0 {
			originCount++
			continue
		}
		angleRad := math.Atan2(float64(dy), float64(dx))
		polarAngles = append(polarAngles, angleRad)
	}

	sort.Float64s(polarAngles)

	n := len(polarAngles)
	for i := 0; i < n; i++ {
		polarAngles = append(polarAngles, polarAngles[i]+2*math.Pi)
	}

	maxCount := 0
	left := 0
	angleRad := float64(angle) * math.Pi / 180

	for right := 0; right < 2*n; right++ {
		for polarAngles[right]-polarAngles[left] > angleRad {
			left++
		}
		maxCount = max(maxCount, right-left+1)
	}

	return originCount + maxCount
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}