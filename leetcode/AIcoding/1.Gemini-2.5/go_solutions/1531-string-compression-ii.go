package main

import (
	"math"
)

func getLen(count int) int {
	if count == 0 {
		return 0
	}
	if count == 1 {
		return 1
	}
	if count < 10 {
		return 2 // e.g., "a2"
	}
	if count < 100 {
		return 3 // e.g., "a99"
	}
	return 4 // e.g., "a100"
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func getLengthOfOptimalCompression(s string, k int) int {
	n := len(s)
	// dp[i][j] represents the minimum compressed length of the prefix s[0...i-1]
	// after exactly j characters have been deleted.
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
		for j := range dp[i] {
			dp[i][j] = math.MaxInt32 / 2 // Initialize with a large value to represent infinity.
			// Using math.MaxInt32 / 2 prevents overflow when adding to it.
		}
	}

	// Base case: an empty string (prefix of length 0) with 0 deletions has 0 compressed length.
	dp[0][0] = 0

	// Iterate through each character of the string s.
	for i := 1; i <= n; i++ {
		// Iterate through each possible number of deletions.
		for j := 0; j <= k; j++ {
			// Option 1: Delete the current character s[i-1].
			// This is possible if we have deletions remaining (j > 0).
			if j > 0 {
				dp[i][j] = min(dp[i][j], dp[i-1][j-1])
			}

			// Option 2: Keep the current character s[i-1] and form a block ending at s[i-1].
			// We iterate backwards from s[i-1] to find the start of this block (index p).
			sameCharCount := 0 // Counts characters equal to s[i-1] within the current block s[p...i-1].
			otherCharCount := 0 // Counts characters NOT equal to s[i-1] within s[p...i-1].
			for p := i - 1; p >= 0; p-- {
				if s[p] == s[i-1] {
					sameCharCount++
				} else {
					otherCharCount++
				}

				// If the number of characters to delete (`otherCharCount`) from s[p...i-1]
				// is within our allowed deletions `j`, then this is a valid state.
				if j >= otherCharCount {
					// The compressed length for the prefix s[0...p-1] with `j - otherCharCount` deletions
					// plus the compressed length of the current block of `sameCharCount` characters.
					prevCompressedLen := dp[p][j-otherCharCount]
					currentBlockLen := getLen(sameCharCount)
					dp[i][j] = min(dp[i][j], prevCompressedLen+currentBlockLen)
				}
			}
		}
	}

	// The result is the minimum compressed length for the entire string s (length n)
	// after exactly k deletions.
	return dp[n][k]
}