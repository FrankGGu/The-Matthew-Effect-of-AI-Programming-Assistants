package main

import "math"

func maximizeNumberofSubsequences(text string, pattern string) int64 {
	p0 := pattern[0]
	p1 := pattern[1]

	var p0CountForSubsequences int64 = 0
	var originalSubsequences int64 = 0
	var totalP0InText int64 = 0
	var totalP1InText int64 = 0

	for i := 0; i < len(text); i++ {
		char := text[i]
		if char == p1 {
			originalSubsequences += p0CountForSubsequences
			totalP1InText++
		}
		if char == p0 {
			p0CountForSubsequences++
			totalP0InText++
		}
	}

	// Option 1: Insert pattern[0]
	// Inserting pattern[0] at any position before the first pattern[1]
	// or at the very beginning of the string will maximize the number of new subsequences.
	// Each new pattern[0] can form a subsequence with all existing pattern[1]s in the text.
	// So, adding a pattern[0] effectively adds 'totalP1InText' new subsequences.
	countAfterInsertingP0 := originalSubsequences + totalP1InText

	// Option 2: Insert pattern[1]
	// Inserting pattern[1] at any position after the last pattern[0]
	// or at the very end of the string will maximize the number of new subsequences.
	// Each new pattern[1] can form a subsequence with all existing pattern[0]s in the text.
	// So, adding a pattern[1] effectively adds 'totalP0InText' new subsequences.
	countAfterInsertingP1 := originalSubsequences + totalP0InText

	return int64(math.Max(float64(countAfterInsertingP0), float64(countAfterInsertingP1)))
}