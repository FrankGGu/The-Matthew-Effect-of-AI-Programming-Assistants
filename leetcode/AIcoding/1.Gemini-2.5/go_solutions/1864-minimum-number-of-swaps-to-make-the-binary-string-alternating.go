package main

import (
	"math"
)

func minSwaps(s string) int {
	n := len(s)
	count0 := 0
	count1 := 0
	for _, char := range s {
		if char == '0' {
			count0++
		} else {
			count1++
		}
	}

	if abs(count0-count1) > 1 {
		return -1
	}

	ans := math.MaxInt32

	// Case 1: Target string starts with '0' (e.g., "01010...")
	// This pattern requires:
	// If N is even: count0 = N/2, count1 = N/2
	// If N is odd: count0 = (N+1)/2, count1 = (N-1)/2
	// This can be simplified to: count0 == (n+1)/2 and count1 == n/2 using integer division.
	if count0 == (n+1)/2 && count1 == n/2 {
		mismatches := calculateMismatches(s, '0')
		ans = min(ans, mismatches/2)
	}

	// Case 2: Target string starts with '1' (e.g., "10101...")
	// This pattern requires:
	// If N is even: count1 = N/2, count0 = N/2
	// If N is odd: count1 = (N+1)/2, count0 = (N-1)/2
	// This can be simplified to: count1 == (n+1)/2 and count0 == n/2 using integer division.
	if count1 == (n+1)/2 && count0 == n/2 {
		mismatches := calculateMismatches(s, '1')
		ans = min(ans, mismatches/2)
	}

	if ans == math.MaxInt32 {
		return -1
	}
	return ans
}

func calculateMismatches(s string, startChar byte) int {
	mismatches := 0
	expectedChar := startChar
	for _, char := range s {
		if char != rune(expectedChar) {
			mismatches++
		}
		if expectedChar == '0' {
			expectedChar = '1'
		} else {
			expectedChar = '0'
		}
	}
	return mismatches
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}