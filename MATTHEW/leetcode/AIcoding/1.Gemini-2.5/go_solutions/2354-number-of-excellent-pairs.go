package main

import (
	"math/bits"
)

func countExcellentPairs(nums []int, k int) int64 {
	seen := make(map[int]struct{})
	for _, num := range nums {
		seen[num] = struct{}{}
	}

	// freq[i] stores the count of unique numbers from nums that have 'i' set bits.
	// Max possible set bits for a number up to 10^9 is 30 (e.g., 2^30 - 1).
	// So, an array of size 31 (for indices 0 to 30) is sufficient.
	freq := make([]int, 31)
	for num := range seen {
		freq[bits.OnesCount(uint(num))]++
	}

	var ans int64
	// Iterate through all possible combinations of set bit counts (i, j)
	// for num1 and num2 respectively.
	for i := 0; i < 31; i++ {
		for j := 0; j < 31; j++ {
			// If the sum of set bits is greater than or equal to k,
			// then any number with 'i' set bits paired with any number
			// with 'j' set bits forms an excellent pair.
			if i+j >= k {
				// Multiply the counts of numbers with 'i' set bits and 'j' set bits.
				// This correctly counts all ordered pairs (num1, num2)
				// where num1 has 'i' bits and num2 has 'j' bits.
				ans += int64(freq[i]) * int64(freq[j])
			}
		}
	}

	return ans
}