package main

import (
	"fmt"
)

func getHint(secret string, guess string) string {
	bulls := 0
	cows := 0

	// Frequency arrays for non-bull digits
	// secretCounts[digit] stores count of digit in secret (excluding bulls)
	// guessCounts[digit] stores count of digit in guess (excluding bulls)
	secretCounts := make([]int, 10)
	guessCounts := make([]int, 10)

	n := len(secret)

	for i := 0; i < n; i++ {
		if secret[i] == guess[i] {
			bulls++
		} else {
			// Convert char to int digit
			sDigit := secret[i] - '0'
			gDigit := guess[i] - '0'
			secretCounts[sDigit]++
			guessCounts[gDigit]++
		}
	}

	// Calculate cows from the frequency arrays
	for i := 0; i < 10; i++ {
		cows += min(secretCounts[i], guessCounts[i])
	}

	return fmt.Sprintf("%d bulls %d cows", bulls, cows)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}