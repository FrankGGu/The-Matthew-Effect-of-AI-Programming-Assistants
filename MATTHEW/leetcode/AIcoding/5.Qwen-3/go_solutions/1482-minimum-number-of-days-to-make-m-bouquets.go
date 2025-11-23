package main

func minDays(bloomed []int, m int, k int) int {
	if m*k > len(bloomed) {
		return -1
	}

	left, right := 0, 1000000000
	for left < right {
		mid := left + (right-left)/2
		if canMake(bloomed, m, k, mid) {
			right = mid
		} else {
			left = mid + 1
		}
	}
	return left
}

func canMake(bloomed []int, m, k, days int) bool {
	bouquets := 0
	consecutive := 0

	for _, day := range bloomed {
		if day <= days {
			consecutive++
			if consecutive == k {
				bouquets++
				consecutive = 0
			}
		} else {
			consecutive = 0
		}
	}

	return bouquets >= m
}