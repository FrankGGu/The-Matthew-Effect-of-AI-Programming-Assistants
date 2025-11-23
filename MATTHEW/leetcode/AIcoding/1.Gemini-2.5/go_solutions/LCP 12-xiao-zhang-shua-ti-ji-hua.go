package main

import (
	"math"
)

func solve(time []int, m int) int {
	low := 0
	high := 0
	for _, t := range time {
		if t > low {
			low = t
		}
		high += t
	}

	ans := high

	for low <= high {
		mid := low + (high-low)/2
		if check(mid, time, m) {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}
	return ans
}

func check(maxTimePerDay int, time []int, m int) bool {
	daysNeeded := 1
	currentDayTime := 0
	for _, t := range time {
		if t > maxTimePerDay {
			return false
		}
		if currentDayTime+t <= maxTimePerDay {
			currentDayTime += t
		} else {
			daysNeeded++
			currentDayTime = t
		}
	}
	return daysNeeded <= m
}