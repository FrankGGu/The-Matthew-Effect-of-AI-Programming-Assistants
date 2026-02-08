package main

import (
	"math"
	"strings"
)

func shortestSuperstring(words []string) string {
	n := len(words)

	// Precompute overlaps
	// overlap[i][j] stores the length of the longest suffix of words[i]
	// that is also a prefix of words[j].
	overlap := make([][]int, n)
	for i := range overlap {
		overlap[i] = make([]int, n)
	}

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if i == j {
				continue
			}
			maxOverlap := 0
			// Iterate from max possible overlap down to 1
			// The overlap length cannot exceed the length of the shorter string
			for k := 1; k <= len(words[i]) && k <= len(words[j]); k++ {
				// Check if suffix of words[i] of length k matches prefix of words[j] of length k
				if strings.HasSuffix(words[i], words[j][:k]) {
					maxOverlap = k
				}
			}
			overlap[i][j] = maxOverlap
		}
	}

	// dp[mask][i] will store the minimum length of a superstring that contains
	// all strings represented by 'mask', with the last string being words[i].
	dp := make([][]int, 1<<n)
	// path[mask][i] will store the index of the string that came before words[i]
	// in the optimal superstring for dp[mask][i].
	path := make([][]int, 1<<n)

	for i := 0; i < (1 << n); i++ {
		dp[i] = make([]int, n)
		path[i] = make([]int, n)
		for j := 0; j < n; j++ {
			dp[i][j] = math.MaxInt32 // Initialize with a large value (infinity)
			path[i][j] = -1
		}
	}

	// Base cases: A superstring containing only words[i] has length len(words[i]).
	for i := 0; i < n; i++ {
		dp[1<<i][i] = len(words[i])
	}

	// Fill the DP table
	for mask := 1; mask < (1 << n); mask++ {
		for i := 0; i < n; i++ { // words[i] is the current last word
			if (mask>>i)&1 == 0 { // If words[i] is not in the current mask, skip
				continue
			}

			// Consider all possible previous words words[j]
			for j := 0; j < n; j++ {
				if i == j || (mask>>j)&1 == 0 { // words[j] must be different from words[i] and also in the mask
					continue
				}

				prevMask := mask ^ (1 << i) // Mask without words[i]
				if dp[prevMask][j] != math.MaxInt32 {
					// Calculate the new length if words[i] is appended after words[j]
					newLen := dp[prevMask][j] + len(words[i]) - overlap[j][i]
					if newLen < dp[mask][i] {
						dp[mask][i] = newLen
						path[mask][i] = j
					}
				}
			}
		}
	}

	// Find the minimum total length and the index of the last word in the optimal superstring
	minLen := math.MaxInt32
	lastIdx := -1
	fullMask := (1 << n) - 1
	for i := 0; i < n; i++ {
		if dp[fullMask][i] < minLen {
			minLen = dp[fullMask][i]
			lastIdx = i
		}
	}

	// Reconstruct the path (order of words)
	resultOrder := make([]int, n)
	currentMask := fullMask
	currentIndex := lastIdx

	for k := n - 1; k >= 0; k-- {
		resultOrder[k] = currentIndex
		prevIndex := path[currentMask][currentIndex]
		currentMask ^= (1 << currentIndex) // Remove currentIndex from the mask
		currentIndex = prevIndex           // Move to the previous word
	}

	// Build the final superstring
	superstring := words[resultOrder[0]]
	for k := 1; k < n; k++ {
		prevWordIdx := resultOrder[k-1]
		currWordIdx := resultOrder[k]
		superstring += words[currWordIdx][overlap[prevWordIdx][currWordIdx]:]
	}

	return superstring
}