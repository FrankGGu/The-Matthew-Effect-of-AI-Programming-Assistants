package main

import (
	"fmt"
)

func countGoodPartitions(nums []int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	lastOcc := make(map[int]int)
	for i, num := range nums {
		lastOcc[num] = i
	}

	const MOD = 1_000_000_007

	maxReach := 0
	numBlocks := 0

	for i := 0; i < n; i++ {
		// Update maxReach for the current segment.
		// maxReach keeps track of the farthest last occurrence encountered so far
		// within the current potential "self-contained" block.
		if lastOcc[nums[i]] > maxReach {
			maxReach = lastOcc[nums[i]]
		}

		// If the current index i equals maxReach, it means all numbers in the segment
		// from the start of the current block up to i have their last occurrences
		// within this segment [start_of_block, i].
		// This signifies the end of a "maximal good segment".
		if i == maxReach {
			numBlocks++
		}
	}

	// If there are 'k' maximal good segments, there are 'k-1' possible cut points
	// between them. Each of these 'k-1' points can either have a cut or not.
	// So, there are 2^(k-1) ways to partition these segments.
	// For example, if k=1, 2^(1-1) = 2^0 = 1 way (the whole array is one partition).
	return power(2, numBlocks-1, MOD)
}

func power(base, exp, mod int) int {
	res := 1
	base %= mod
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % mod
		}
		base = (base * base) % mod
		exp /= 2
	}
	return res
}