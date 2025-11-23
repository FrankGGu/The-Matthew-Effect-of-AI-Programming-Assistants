package main

import (
	"math/bits"
)

func minimumOperations(num int, sub int) int {
	// Iterate through the possible number of operations, 'i'.
	// The maximum number of set bits for a 64-bit integer is 64.
	// For num up to 10^9, the maximum number of set bits is 30 (for 2^30 - 1).
	// If 'i' is greater than the maximum possible number of set bits,
	// the condition bits.OnesCount64(uint64(val)) <= i will always be true.
	// A loop up to around 60-64 is sufficient to cover all relevant cases
	// where the popcount condition might be restrictive.
	for i := 1; i <= 64; i++ {
		// Calculate the target sum 'val' that needs to be formed by 'i' positive integers.
		// val = k_1 + k_2 + ... + k_i
		val := num - i*sub

		// Condition 1: The sum 'val' must be non-negative.
		// Condition 2: Since each k_j >= 1, the sum 'val' must be at least 'i'.
		// If val < i, it's impossible to form 'val' as a sum of 'i' positive integers.
		// Since 'val' is non-increasing (as 'i' increases and 'sub' >= 1)
		// and 'i' is increasing, if 'val < i' is true for current 'i',
		// it will also be true for all subsequent 'i' values.
		if val < i {
			break // No solution possible with more operations.
		}

		// Condition 3: The number of set bits (popcount) in 'val' must be less than or equal to 'i'.
		// This is because 'val' can be expressed as a sum of bits.OnesCount64(val) powers of 2.
		// We can always split a power of 2 (e.g., 2^p = 2^(p-1) + 2^(p-1)) to increase the number of terms by 1,
		// until we reach 'i' terms, as long as bits.OnesCount64(val) <= i.
		if bits.OnesCount64(uint64(val)) <= i {
			return i // Found the minimum number of operations
		}
	}

	// If no solution is found within the checked range of operations.
	return -1
}