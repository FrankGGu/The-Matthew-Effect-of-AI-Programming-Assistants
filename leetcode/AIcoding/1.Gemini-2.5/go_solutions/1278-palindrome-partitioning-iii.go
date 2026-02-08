import "math"

func palindromePartitionIII(s string, k int) int {
	n := len(s)

	// Precompute cost[i][j]: minimum changes to make s[i...j] a palindrome
	// cost[i][j] stores the number of character changes needed for substring s[i...j]
	cost := make([][]int, n)
	for i := range cost {
		cost[i] = make([]int, n)
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			if s[i] == s[j] {
				if length == 2 {
					cost[i][j] = 0
				} else {
					cost[i][j] = cost[i+1][j-1]
				}
			} else {
				if length == 2 {
					cost[i][j] = 1
				} else {
					cost[i][j] = cost[i+1][j-1] + 1
				}
			}
		}
	}

	// dp[j][i]: minimum changes to partition s[0...i-1] into j palindromic substrings
	// i represents the length of the prefix s[0...i-1] (so i goes from 1 to n)
	// j represents the number of partitions (so j goes from 1 to k)
	dp := make([][]int, k+1)
	for j := range dp {
		dp[j] = make([]int, n+1)
		for i := range dp[j] {
			dp[j][i] = math.MaxInt32 // Initialize with a large value (infinity)
		}
	}

	// Base case: 0 partitions for an empty string (length 0) costs 0 changes
	dp[0][0] = 0

	// Iterate through the number of partitions
	for j := 1; j <= k; j++ {
		// Iterate through the length of the prefix string
		for i := 1; i <= n; i++ {
			// A prefix of length 'i' can only be partitioned into 'j' parts if i >= j
			if i < j {
				continue
			}

			// To form 'j' partitions for s[0...i-1], the last partition must be s[p...i-1]
			// and the prefix s[0...p-1] must have been partitioned into 'j-1' parts.
			// 'p' is the starting index of the current (j-th) partition.
			// 'p' also represents the length of the prefix for the previous j-1 partitions (s[0...p-1]).
			for p := 0; p < i; p++ {
				// Check if dp[j-1][p] is reachable (not infinity)
				if dp[j-1][p] != math.MaxInt32 {
					// The cost for the current (j-th) partition s[p...i-1]
					currentPartitionCost := cost[p][i-1]
					dp[j][i] = min(dp[j][i], dp[j-1][p]+currentPartitionCost)
				}
			}
		}
	}

	return dp[k][n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}