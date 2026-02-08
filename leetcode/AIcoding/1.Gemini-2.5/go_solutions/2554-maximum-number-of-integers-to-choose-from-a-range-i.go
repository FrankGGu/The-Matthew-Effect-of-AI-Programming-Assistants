package main

import "sort"

func maxCount(banned []int, n int, maxSum int) int {
	bannedMap := make(map[int]bool)
	for _, b := range banned {
		bannedMap[b] = true
	}

	count := 0
	currentSum := 0

	for i := 1; i <= n; i++ {
		if !bannedMap[i] {
			if currentSum+i <= maxSum {
				currentSum += i
				count++
			} else {
				break
			}
		}
	}

	return count
}