package main

import (
	"fmt"
)

func countSubMultisets(nums []int, l int, r int) int {
	const MOD = 1_000_000_007

	counts := make(map[int]int)
	zeroCount := 0
	for _, num := range nums {
		if num == 0 {
			zeroCount++
		} else {
			counts[num]++
		}
	}

	dp := make([]int, r+1)
	dp[0] = 1 // One way to make sum 0 (the empty multiset)

	for num, count := range counts {
		// Iterate sums from r down to 0.
		// When calculating dp[j + k*num], dp[j] refers to the state
		// *before* considering the current 'num'. This is crucial
		// for correctly handling bounded item counts.
		for j := r; j >= 0; j-- {
			if dp[j] == 0 {
				continue // If sum 'j' is not reachable, no need to extend it
			}
			// Try adding 'k' instances of the current 'num'
			for k := 1; k <= count; k++ {
				if j+k*num <= r {
					dp[j+k*num] = (dp[j+k*num] + dp[j]) % MOD
				} else {
					break // Further additions of 'num' will exceed 'r'
				}
			}
		}
	}

	totalWays := 0
	for s := l; s <= r; s++ {
		totalWays = (totalWays + dp[s]) % MOD
	}

	// Account for zeros. If there are 'zeroCount' zeros, we can pick
	// 0, 1, ..., 'zeroCount' of them. This gives 'zeroCount + 1' choices
	// for each sub-multiset formed by non-zero numbers.
	totalWays = (totalWays * (zeroCount + 1)) % MOD

	return totalWays
}