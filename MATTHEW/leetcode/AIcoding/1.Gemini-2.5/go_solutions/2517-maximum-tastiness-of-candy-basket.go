package main

import "sort"

func maximumTastiness(price []int, k int) int {
	sort.Ints(price)
	n := len(price)

	check := func(tastiness int) bool {
		count := 1
		lastPrice := price[0]
		for i := 1; i < n; i++ {
			if price[i]-lastPrice >= tastiness {
				count++
				lastPrice = price[i]
			}
		}
		return count >= k
	}

	low := 0
	high := price[n-1] - price[0]
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