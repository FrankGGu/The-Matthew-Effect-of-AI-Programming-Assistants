package main

import (
	"strconv"
)

func numberOfWays(s string) int {
	n := len(s)
	MOD := 1_000_000_007

	// If the string starts with '0', no valid positive integer can be formed.
	if s[0] == '0' {
		return 0
	}

	// lcp[i][j] stores the length of the longest common prefix of s[i:] and s[j:]
	// This is used for O(1) lexicographical comparison of substrings.
	lcp := make([][]int, n+1)
	for i := range lcp {
		lcp[i] = make([]int, n+1)
	}

	// Build LCP table in O(N^2)
	for i := n - 1; i >= 0; i-- {
		for j := n - 1; j >= 0; j-- {
			if s[i] == s[j] {
				lcp[i][j] = 1 + lcp[i+1][j+1]
			} else {
				lcp[i][j] = 0
			}
		}
	}

	// dp[i][prevLen] stores the number of ways to separate the prefix s[0...i-1]
	// such that the last number s[i-prevLen...i-1] has length prevLen.
	dp := make([][]int, n+1)
	// sum_dp[i][maxLen] stores the sum of dp[i][l] for l from 1 to maxLen.
	// This is a prefix sum optimization for the case where the current number is longer
	// than the previous number (Part 1 in the DP transition).
	sum_dp := make([][]int, n+1)

	for i := range dp {
		dp[i] = make([]int, n+1)
		sum_dp[i] = make([]int, n+1)
	}

	// Iterate through all possible end positions (exclusive) for the current number.
	// `i` represents the length of the prefix s[0...i-1].
	for i := 1; i <= n; i++ {
		// Iterate through all possible lengths for the last number in the separation.
		// `prevLen` is the length of the number s[i-prevLen...i-1].
		for prevLen := 1; prevLen <= i; prevLen++ {
			// `j` is the start index of the current number s[j...i-1].
			j := i - prevLen

			// A number cannot start with '0'.
			if s[j] == '0' {
				dp[i][prevLen] = 0
			} else {
				currentWays := 0
				if j == 0 {
					// If j == 0, this is the first number in the sequence (s[0...i-1]).
					// There's only one way to form it.
					currentWays = 1
				} else {
					// We need to sum dp[j][k] for valid previous lengths `k`.
					// `s[j...i-1]` is the current number (length `prevLen`).
					// `s[j-k...j-1]` is the previous number (length `k`).

					// Part 1: Previous number has length `k < prevLen`.
					// If the current number is strictly longer than the previous number,
					// it is always numerically greater.
					// We sum dp[j][k] for 1 <= k < prevLen and k <= j.
					limitK := min(j, prevLen-1)
					if limitK >= 1 {
						currentWays = (currentWays + sum_dp[j][limitK]) % MOD
					}

					// Part 2: Previous number has length `k == prevLen`.
					// We need to compare `s[j...i-1]` with `s[j-prevLen...j-1]` lexicographically.
					if prevLen <= j { // Ensure the previous number can actually have length `prevLen`.
						prevStart := j - prevLen // Start index of the previous number.

						// Use LCP table for O(1) comparison.
						commonLen := lcp[j][prevStart]

						isGreaterOrEqual := false
						if commonLen >= prevLen {
							// The prefixes are identical for the full length, so numbers are equal.
							isGreaterOrEqual = true
						} else if s[j+commonLen] > s[prevStart+commonLen] {
							// The current number is greater at the first differing character.
							isGreaterOrEqual = true
						}

						if isGreaterOrEqual {
							currentWays = (currentWays + dp[j][prevLen]) % MOD
						}
					}
				}
				dp[i][prevLen] = currentWays
			}
			// Update sum_dp for the current `i`.
			// sum_dp[i][prevLen] = sum(dp[i][l] for l=1 to prevLen)
			sum_dp[i][prevLen] = (sum_dp[i][prevLen-1] + dp[i][prevLen]) % MOD
		}
	}

	// The total number of ways to separate s[0...n-1] is the sum of all dp[n][l] for l=1 to n.
	return sum_dp[n][n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}