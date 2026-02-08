package main

import "math"

func findAllConcatenatedWordsInADict(words []string) []string {
	wordSet := make(map[string]bool)
	for _, word := range words {
		wordSet[word] = true
	}

	result := []string{}
	for _, word := range words {
		// Temporarily remove the current word from the set
		// A word cannot be formed by concatenating itself.
		delete(wordSet, word)

		if checkConcatenated(word, wordSet) {
			result = append(result, word)
		}

		// Add the word back to the set for subsequent checks
		wordSet[word] = true
	}

	return result
}

func checkConcatenated(word string, wordSet map[string]bool) bool {
	n := len(word)
	if n == 0 {
		return false
	}

	// dp[i] stores the minimum number of words needed to form word[:i]
	// Initialize with n + 1 (effectively infinity for this problem's constraints)
	// A word of length n can be formed by at most n single-character words.
	dp := make([]int, n+1)
	for i := range dp {
		dp[i] = n + 1
	}
	dp[0] = 0 // 0 words needed to form an empty prefix

	for i := 1; i <= n; i++ {
		for j := 0; j < i; j++ {
			// If word[:j] is reachable (dp[j] is not infinity)
			// AND word[j:i] is a valid word in the dictionary
			if dp[j] != n+1 && wordSet[word[j:i]] {
				dp[i] = min(dp[i], dp[j]+1)
			}
		}
	}

	// If dp[n] is >= 2, it means the entire word can be formed by at least two words
	return dp[n] >= 2
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}