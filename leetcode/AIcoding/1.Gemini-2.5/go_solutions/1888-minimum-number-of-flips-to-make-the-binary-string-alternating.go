package main

import (
	"math"
)

func minFlips(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	// Extend the string to s + s to easily simulate all rotations
	// A window of length n in t will represent a rotated version of s
	t := s + s

	// f0: flips needed to match "0101..." pattern
	// f1: flips needed to match "1010..." pattern
	f0 := 0
	f1 := 0

	// Calculate initial flips for the first window (s[0...n-1])
	for k := 0; k < n; k++ {
		charVal := int(t[k] - '0')

		// For "0101..." pattern: target character at index k is k%2
		// (0 at even indices, 1 at odd indices)
		if charVal != k%2 {
			f0++
		}

		// For "1010..." pattern: target character at index k is (k+1)%2
		// (1 at even indices, 0 at odd indices)
		if charVal != (k+1)%2 {
			f1++
		}
	}

	minResult := math.Min(float64(f0), float64(f1))

	// Slide the window n times to cover all unique rotations
	// i represents the index of the character being removed from the left
	for i := 0; i < n; i++ {
		// Character leaving the window: t[i]
		charValRemoved := int(t[i] - '0')

		// Remove its contribution from f0 and f1 (it was at window index 0)
		if charValRemoved != 0%2 { // Target for "0101..." at window index 0 is '0'
			f0--
		}
		if charValRemoved != (0+1)%2 { // Target for "1010..." at window index 0 is '1'
			f1--
		}

		// When the window slides, all characters shift their relative index by -1.
		// This means their target pattern (based on parity) flips.
		// So, the current f0 count effectively becomes the new f1 count, and vice-versa,
		// for the characters remaining in the window.
		f0, f1 = f1, f0

		// Character entering the window: t[i+n]
		// This character will be at window index n-1 in the new window
		charValAdded := int(t[i+n] - '0')

		// Add its contribution to f0 and f1 (it is at window index n-1)
		if charValAdded != (n-1)%2 { // Target for "0101..." at window index n-1
			f0++
		}
		if charValAdded != ((n-1)+1)%2 { // Target for "1010..." at window index n-1
			f1++
		}

		// Update minimum flips with the current window's f0 and f1
		minResult = math.Min(minResult, float64(f0))
		minResult = math.Min(minResult, float64(f1))
	}

	return int(minResult)
}