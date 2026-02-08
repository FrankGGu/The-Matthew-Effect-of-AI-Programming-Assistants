package main

import "math"

func minOperations(s string, target string) int {
	n := len(s)
	m := len(target)

	// dp[j] will store the minimum operations to make target[0...i-1] a subsequence of s[0...j-1].
	// We use O(N) space by only keeping track of the previous and current row.
	// prev_dp stores values for target[0...i-2]
	// curr_dp stores values for target[0...i-1]
	prev_dp := make([]int, n+1)
	curr_dp := make([]int, n+1)

	// Base case: dp[0][j] = 0 for all j (empty target requires 0 operations).
	// This is handled by initializing prev_dp to all zeros.

	// A value of n+1 or greater indicates an impossible state for the current subproblem,
	// as the maximum possible removals from s is n.
	infinity := n + 1

	for i := 1; i <= m; i++ {
		// Base case: dp[i][0] = infinity for i > 0 (non-empty target with empty s is impossible).
		curr_dp[0] = infinity

		for j := 1; j <= n; j++ {
			if s[j-1] == target[i-1] {
				// Option 1: Match s[j-1] with target[i-1]. Cost is prev_dp[j-1] (dp[i-1][j-1]).
				// Option 2: Remove s[j-1]. Cost is curr_dp[j-1] + 1 (dp[i][j-1] + 1).
				curr_dp[j] = min(curr_dp[j-1]+1, prev_dp[j-1])
			} else {
				// Must remove s[j-1]. Cost is curr_dp[j-1] + 1 (dp[i][j-1] + 1).
				curr_dp[j] = curr_dp[j-1] + 1
			}
		}
		// After computing curr_dp for the current 'i', it becomes prev_dp for the next 'i'.
		// Swap the slices to avoid copying.
		prev_dp, curr_dp = curr_dp, prev_dp
	}

	// The result for target[0...m-1] and s[0...n-1] is in prev_dp[n]
	// (because prev_dp holds the values for the last completed row, which is `m`).
	return prev_dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}