package main

import (
	"math"
)

func minSpeedOnTime(dist []int, hour float64) int {
	left, right := 1, int(1e9)
	result := -1

	for left <= right {
		mid := left + (right-left)/2
		if canArriveOnTime(dist, hour, mid) {
			result = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return result
}

func canArriveOnTime(dist []int, hour float64, speed int) bool {
	time := 0.0
	for i := 0; i < len(dist); i++ {
		time += math.Ceil(float64(dist[i]) / float64(speed))
		if i < len(dist)-1 {
			time += 1.0
		}
	}
	return time <= hour
}