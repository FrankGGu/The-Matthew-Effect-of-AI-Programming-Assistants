package main

import (
	"sort"
)

func maxDistance(position []int, m int) int {
	sort.Ints(position)

	n := len(position)

	check := func(force int) bool {
		count := 1
		lastPos := position[0]

		for i := 1; i < n; i++ {
			if position[i]-lastPos >= force {
				count++
				lastPos = position[i]
				if count == m {
					return true
				}
			}
		}
		return false
	}

	low := 1
	high := position[n-1] - position[0]
	ans := 0

	for low <= high {
		mid := low + (high-low)/2
		if check(mid) {
			ans = mid
			low = mid + 1
		} else {
			high = mid - 1
		}
	}

	return ans
}