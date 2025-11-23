package main

import (
	"math"
)

func minimizedMaximum(n int, quantities []int) int {
	maxQuantity := 0
	for _, q := range quantities {
		if q > maxQuantity {
			maxQuantity = q
		}
	}

	low := 1
	high := maxQuantity
	ans := maxQuantity

	for low <= high {
		mid := low + (high-low)/2

		storesNeeded := 0
		for _, q := range quantities {
			storesNeeded += (q + mid - 1) / mid
		}

		if storesNeeded <= n {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return ans
}