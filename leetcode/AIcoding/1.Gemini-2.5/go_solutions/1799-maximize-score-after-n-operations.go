package main

import (
	"math/bits"
)

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxScore(nums []int) int {
	n := len(nums)
	maxMask := 1 << n
	dp := make([]int, maxMask)

	gcds := make([][]int, n)
	for i := 0; i < n; i++ {
		gcds[i] = make([]int, n)
		for j := 0; j < n; j++ {
			gcds[i][j] = gcd(nums[i], nums[j])
		}
	}

	for mask := 0; mask < maxMask; mask++ {
		numPicked := bits.OnesCount(uint(mask))

		if numPicked%2 != 0 {
			continue
		}

		currentOpNum := numPicked/2 + 1

		if currentOpNum > n/2 {
			continue
		}

		for i := 0; i < n; i++ {
			if (mask>>i)&1 == 1 {
				continue
			}

			for j := i + 1; j < n; j++ {
				if (mask>>j)&1 == 1 {
					continue
				}

				nextMask := mask | (1 << i) | (1 << j)

				scoreIncrease := currentOpNum * gcds[i][j]

				dp[nextMask] = max(dp[nextMask], dp[mask]+scoreIncrease)
			}
		}
	}

	return dp[maxMask-1]
}