package main

import (
	"math"
	"math/bits"
	"sort"
)

func minimumIncompatibility(nums []int, k int) int {
	n := len(nums)
	subsetSize := n / k

	sort.Ints(nums)

	incompatibilities := make([]int, 1<<n)
	for i := range incompatibilities {
		incompatibilities[i] = -1
	}

	for mask := 1; mask < (1 << n); mask++ {
		if bits.OnesCount(uint(mask)) == subsetSize {
			currentSubset := make([]int, 0, subsetSize)
			for i := 0; i < n; i++ {
				if (mask>>i)&1 == 1 {
					currentSubset = append(currentSubset, nums[i])
				}
			}

			hasDuplicates := false
			for i := 0; i < subsetSize-1; i++ {
				if currentSubset[i] == currentSubset[i+1] {
					hasDuplicates = true
					break
				}
			}

			if !hasDuplicates {
				incompatibilities[mask] = currentSubset[subsetSize-1] - currentSubset[0]
			}
		}
	}

	dp := make([]int, 1<<n)
	for i := range dp {
		dp[i] = math.MaxInt32
	}
	dp[0] = 0

	for mask := 1; mask < (1 << n); mask++ {
		if bits.OnesCount(uint(mask))%subsetSize != 0 {
			continue
		}

		for submask := mask; submask > 0; submask = (submask - 1) & mask {
			if incompatibilities[submask] != -1 {
				prevMask := mask ^ submask
				if dp[prevMask] != math.MaxInt32 {
					if dp[prevMask]+incompatibilities[submask] < dp[mask] {
						dp[mask] = dp[prevMask] + incompatibilities[submask]
					}
				}
			}
		}
	}

	result := dp[(1<<n)-1]
	if result == math.MaxInt32 {
		return -1
	}
	return result
}