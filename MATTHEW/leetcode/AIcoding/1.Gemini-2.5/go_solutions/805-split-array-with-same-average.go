package main

import (
	"sort"
)

func splitArraySameAverage(nums []int) bool {
	n := len(nums)
	if n == 1 {
		return false
	}

	totalSum := 0
	for _, num := range nums {
		totalSum += num
	}

	// Meet-in-the-middle approach
	// Split the array into two halves.
	nL := n / 2
	nR := n - nL // nR can be equal to nL or nL+1

	// sumsL[k] will store all possible sums using k elements from the left half.
	// Use map[int]bool for efficient lookup and to store distinct sums.
	sumsL := make([]map[int]bool, nL+1)
	for i := 0; i <= nL; i++ {
		sumsL[i] = make(map[int]bool)
	}
	sumsL[0][0] = true // Base case: 0 elements sum to 0

	// Generate all possible sums for subsets of the left half
	for _, num := range nums[:nL] {
		for k := nL - 1; k >= 0; k-- { // Iterate k downwards to avoid using the same num multiple times for the same k
			if len(sumsL[k]) > 0 {
				for s := range sumsL[k] {
					sumsL[k+1][s+num] = true
				}
			}
		}
	}

	// sumsR[k] will store all possible sums using k elements from the right half.
	sumsR := make([]map[int]bool, nR+1)
	for i := 0; i <= nR; i++ {
		sumsR[i] = make(map[int]bool)
	}
	sumsR[0][0] = true // Base case: 0 elements sum to 0

	// Generate all possible sums for subsets of the right half
	for _, num := range nums[nL:] {
		for k := nR - 1; k >= 0; k-- { // Iterate k downwards
			if len(sumsR[k]) > 0 {
				for s := range sumsR[k] {
					sumsR[k+1][s+num] = true
				}
			}
		}
	}

	// Combine results from sumsL and sumsR
	// We are looking for a subset A with length kTotal and sum sTotal
	// such that sTotal / kTotal == totalSum / n.
	// This is equivalent to sTotal * n == totalSum * kTotal.
	// Also, A must be non-empty and not the whole array, so 1 <= kTotal < n.
	for kL := 0; kL <= nL; kL++ {
		for sL := range sumsL[kL] {
			for kR := 0; kR <= nR; kR++ {
				kTotal := kL + kR
				// A must be non-empty and not the entire original array
				if kTotal == 0 || kTotal == n {
					continue
				}

				// The target sum sTotal must be an integer, so (totalSum * kTotal) must be divisible by n.
				if (totalSum*kTotal)%n != 0 {
					continue
				}

				targetSTotal := (totalSum * kTotal) / n
				targetSR := targetSTotal - sL // The sum needed from the right half

				// Check if targetSR can be formed by kR elements from the right half
				if sumsR[kR][targetSR] {
					return true
				}
			}
		}
	}

	return false
}