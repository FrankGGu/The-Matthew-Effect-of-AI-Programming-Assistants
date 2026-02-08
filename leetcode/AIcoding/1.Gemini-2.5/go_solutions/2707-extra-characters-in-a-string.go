package main

import (
	"math"
)

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func extraCharacters(s string, dictionary []string) int {
	dictSet := make(map[string]bool)
	for _, word := range dictionary {
		dictSet[word] = true
	}

	n := len(s)
	dp := make([]int, n+1)

	// dp[i] represents the minimum extra characters for the prefix s[0...i-1].
	// dp[0] is 0, as an empty prefix has no extra characters.

	for i := 1; i <= n; i++ {
		// Option 1: The character s[i-1] is an extra character.
		// In this case, the total extra characters for s[0...i-1] would be
		// the extra characters for s[0...i-2] plus 1 (for s[i-1]).
		dp[i] = dp[i-1] + 1

		// Option 2: A substring s[j...i-1] forms a word in the dictionary.
		// We iterate through all possible starting points 'j' for a word
		// that ends at index 'i-1'.
		for j := 0; j < i; j++ {
			sub := s[j:i]
			if dictSet[sub] {
				// If s[j...i-1] is a valid word, then the extra characters
				// for s[0...i-1] could be the extra characters for s[0...j-1].
				// We take the minimum of the current dp[i] and dp[j].
				dp[i] = min(dp[i], dp[j])
			}
		}
	}

	return dp[n]
}