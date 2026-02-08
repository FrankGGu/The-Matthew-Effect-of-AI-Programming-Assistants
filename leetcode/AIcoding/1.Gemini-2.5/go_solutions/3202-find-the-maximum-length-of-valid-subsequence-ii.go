package main

import (
	"math"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func findMaximumLength(nums []int) int {
	// dpExact[val] stores the maximum length of a valid subsequence ending with 'val'.
	dpExact := make(map[int]int) 

	// dpMod7[rem] stores the maximum length of a valid subsequence ending with
	// any number 'x' such that 'x % 7 == rem'.
	dpMod7 := [7]int{}           

	overallMaxLen := 0

	for _, num := range nums {
		currentLen := 1 // A single number forms a subsequence of length 1
		numRem := num % 7

		// Condition 2: (num + prev_val) % 7 == 0
		// This means prev_val % 7 must be (7 - num % 7) % 7.
		targetRem := (7 - numRem) % 7
		if dpMod7[targetRem] > 0 { 
			currentLen = max(currentLen, dpMod7[targetRem]+1)
		}

		// Condition 1: prev_val is a divisor of num
		// Iterate through all divisors 'd' of 'num'.
		// If 'd' was an endpoint of a previous valid subsequence, we can extend it.
		sqrtNum := int(math.Sqrt(float64(num)))
		for d := 1; d <= sqrtNum; d++ {
			if num%d == 0 {
				// Check divisor 'd'
				if val, ok := dpExact[d]; ok {
					currentLen = max(currentLen, val+1)
				}
				// Check divisor 'num/d' (if 'd' is not 'sqrt(num)')
				if d*d != num { 
					if val, ok := dpExact[num/d]; ok {
						currentLen = max(currentLen, val+1)
					}
				}
			}
		}

		// Update DP states for the current 'num'.
		// dpExact[num] should store the maximum length of a subsequence ending with 'num'
		// found so far. If 'num' appears multiple times, we take the maximum.
		if val, ok := dpExact[num]; ok {
			dpExact[num] = max(val, currentLen)
		} else {
			dpExact[num] = currentLen
		}

		// Update dpMod7 for 'numRem'.
		dpMod7[numRem] = max(dpMod7[numRem], currentLen)

		// Update the overall maximum length found.
		overallMaxLen = max(overallMaxLen, currentLen)
	}

	return overallMaxLen
}