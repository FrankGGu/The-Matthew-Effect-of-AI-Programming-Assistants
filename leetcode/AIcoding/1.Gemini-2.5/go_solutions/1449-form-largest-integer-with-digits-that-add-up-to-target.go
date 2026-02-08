package main

import (
	"bytes"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func largestNumber(cost []int, target int) string {
	dpLen := make([]int, target+1)
	// Initialize dpLen. -1 means impossible to achieve this cost.
	// dpLen[0] = 0 means cost 0 can be achieved with 0 digits.
	for i := 1; i <= target; i++ {
		dpLen[i] = -1
	}
	// dpLen[0] is already 0

	// Fill dpLen array
	// dpLen[i] will store the maximum length of a number that sums up to cost i.
	for i := 1; i <= target; i++ {
		for j := 0; j < 9; j++ { // j represents digit (j+1)
			digitCost := cost[j]
			if i-digitCost >= 0 && dpLen[i-digitCost] != -1 {
				// We can form a number for cost i by adding digit (j+1)
				// to the number formed for cost (i - digitCost).
				// The new length would be dpLen[i - digitCost] + 1.
				dpLen[i] = max(dpLen[i], dpLen[i-digitCost]+1)
			}
		}
	}

	// If target cannot be reached or reached with 0 digits (which means no valid integer formed)
	// dpLen[target] < 1 covers both -1 (impossible) and 0 (empty string for positive target).
	if dpLen[target] < 1 {
		return "0"
	}

	// Reconstruct the largest number string
	// Use a bytes.Buffer for efficient string building.
	var res bytes.Buffer
	res.Grow(dpLen[target]) // Pre-allocate capacity

	currTarget := target

	for currTarget > 0 {
		// Iterate digits from 9 down to 1 to ensure lexicographically largest number
		for d := 9; d >= 1; d-- {
			digitCost := cost[d-1]
			if currTarget-digitCost >= 0 && dpLen[currTarget-digitCost] != -1 {
				// Check if using digit 'd' leads to a valid path AND
				// if it maintains the optimal length.
				// dpLen[currTarget - digitCost] + 1 == dpLen[currTarget]
				// This condition means 'd' was part of an optimal path to achieve dpLen[currTarget].
				// Since we iterate d from 9 down to 1, the first digit satisfying this
				// will be the largest possible digit at this position.
				if dpLen[currTarget-digitCost]+1 == dpLen[currTarget] {
					res.WriteByte(byte(d + '0'))
					currTarget -= digitCost
					break // Found the digit for this step, move to next sub-target
				}
			}
		}
	}

	return res.String()
}