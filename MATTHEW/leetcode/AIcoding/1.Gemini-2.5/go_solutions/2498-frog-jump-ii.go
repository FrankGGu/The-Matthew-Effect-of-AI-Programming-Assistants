package main

import "sort"

func frogJumpII(stones []int) int {
	n := len(stones)
	if n == 2 {
		return stones[1] - stones[0]
	}

	check := func(maxJump int) bool {
		f1LastIdx := 0
		f2LastIdx := 0

		for i := 1; i < n-1; i++ {
			canF1Take := (stones[i] - stones[f1LastIdx] <= maxJump)
			canF2Take := (stones[i] - stones[f2LastIdx] <= maxJump)

			if !canF1Take && !canF2Take {
				return false
			} else if canF1Take && !canF2Take {
				f1LastIdx = i
			} else if !canF1Take && canF2Take {
				f2LastIdx = i
			} else {
				// Both can take stones[i]. Assign to the frog that is "further behind"
				// (i.e., whose last visited stone index is smaller).
				// This strategy aims to keep the frogs' progress balanced.
				if f1LastIdx < f2LastIdx {
					f1LastIdx = i
				} else {
					f2LastIdx = i
				}
			}
		}

		return (stones[n-1]-stones[f1LastIdx] <= maxJump) && (stones[n-1]-stones[f2LastIdx] <= maxJump)
	}

	low := 0
	high := stones[n-1] - stones[0]
	ans := high

	for low <= high {
		mid := low + (high-low)/2
		if check(mid) {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return ans
}