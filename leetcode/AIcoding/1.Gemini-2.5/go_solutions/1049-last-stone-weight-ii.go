package main

import "sort"

func lastStoneWeightII(stones []int) int {
	totalSum := 0
	for _, stone := range stones {
		totalSum += stone
	}

	target := totalSum / 2

	// dp[i] will be true if a sum 'i' can be formed using a subset of stones.
	dp := make([]bool, target+1)
	dp[0] = true // A sum of 0 can always be formed (by choosing no stones)

	// Iterate through each stone
	for _, stone := range stones {
		// Iterate backwards from target down to the current stone's weight
		// This prevents using the same stone multiple times in a single subset sum calculation
		for j := target; j >= stone; j-- {
			dp[j] = dp[j] || dp[j-stone]
		}
	}

	// Find the largest sum s1 <= target that can be formed
	s1Max := 0
	for i := target; i >= 0; i-- {
		if dp[i] {
			s1Max = i
			break
		}
	}

	// The other sum s2 will be totalSum - s1Max
	// The minimum difference is |s1Max - s2| = |s1Max - (totalSum - s1Max)| = |2*s1Max - totalSum|
	// Since s1Max is the largest sum <= totalSum/2, 2*s1Max <= totalSum.
	// So, totalSum - 2*s1Max will be the result.
	return totalSum - 2*s1Max
}