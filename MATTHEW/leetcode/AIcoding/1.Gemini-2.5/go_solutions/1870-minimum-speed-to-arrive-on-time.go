package main

import (
	"math"
)

func minSpeedOnTime(dist []int, hour float64) int {
	n := len(dist)

	check := func(s int) bool {
		totalTime := 0.0
		for i := 0; i < n-1; i++ {
			totalTime += math.Ceil(float64(dist[i]) / float64(s))
		}
		totalTime += float64(dist[n-1]) / float64(s)
		return totalTime <= hour
	}

	left, right := 1, 10_000_000_000 

	ans := -1

	for left <= right {
		mid := left + (right-left)/2
		if check(mid) {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return ans
}