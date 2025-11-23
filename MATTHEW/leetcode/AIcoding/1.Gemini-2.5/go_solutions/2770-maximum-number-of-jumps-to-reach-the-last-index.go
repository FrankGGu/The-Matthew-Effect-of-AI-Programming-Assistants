func maximumJumps(nums []int, target int) int {
	n := len(nums)
	dp := make([]int, n)
	// dp[i] stores the maximum number of nodes in a jump sequence from index 0 to index i.
	// Initialize dp[0] to 1, as index 0 is reachable and forms a path of length 1.
	dp[0] = 1

	for i := 0; i < n; i++ {
		// If index i is not reachable from index 0 (dp[i] is still 0), skip it.
		if dp[i] == 0 {
			continue
		}
		for j := i + 1; j < n; j++ {
			// Check conditions for a valid jump from i to j
			if nums[i] < nums[j] && nums[i]+nums[j] <= target {
				// Update dp[j] with the maximum path length to reach j
				dp[j] = max(dp[j], dp[i]+1)
			}
		}
	}

	maxPathLength := 0
	// Find the maximum path length among all reachable indices
	for _, val := range dp {
		maxPathLength = max(maxPathLength, val)
	}

	// If maxPathLength is 1, it means only index 0 was reachable (no actual jumps were made).
	// In this case, return -1 as no valid jump sequence of length >= 2 exists.
	// Otherwise, return maxPathLength, which represents the maximum number of "jumps"
	// as interpreted from the problem's example (number of nodes in the longest path).
	if maxPathLength <= 1 {
		return -1
	}

	return maxPathLength
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}