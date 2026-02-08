package main

import "math"

func minimumSubstringsInPartition(s string) int {
	n := len(s)
	dp := make([]int, n+1)

	// Initialize dp[0] to 0, meaning an empty string requires 0 partitions.
	dp[0] = 0

	// Initialize dp[i] for i > 0 to a large value, representing unreachable states.
	for i := 1; i <= n; i++ {
		dp[i] = math.MaxInt32
	}

	// Iterate through each possible end point of a substring (i)
	for i := 1; i <= n; i++ {
		// counts will store character frequencies for the current substring s[j...i-1]
		counts := [26]int{}

		// Iterate through each possible start point of a substring (j)
		// We iterate j backwards from i-1 to 0 to efficiently update counts
		// for s[j...i-1] from s[j+1...i-1]
		for j := i - 1; j >= 0; j-- {
			// Add the character s[j] to the frequency count
			counts[s[j]-'a']++

			// Check if the current substring s[j...i-1] is a valid partition
			isValidPartition := true
			targetFreq := -1 // Stores the frequency of the first character encountered

			// Iterate through all possible character frequencies
			for k := 0; k < 26; k++ {
				if counts[k] > 0 { // If character 'a'+k is present in the substring
					if targetFreq == -1 {
						// This is the first character encountered with a non-zero frequency
						targetFreq = counts[k]
					} else if counts[k] != targetFreq {
						// If any subsequent character has a different frequency, it's invalid
						isValidPartition = false
						break
					}
				}
			}

			// If s[j...i-1] is a valid partition, try to update dp[i]
			if isValidPartition {
				// We can only extend from a reachable previous state dp[j]
				if dp[j] != math.MaxInt32 {
					dp[i] = min(dp[i], dp[j]+1)
				}
			}
		}
	}

	return dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}