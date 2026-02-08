package main

import "math/bits"

func findIntegers(n int) int {
	// fib[k] stores the count of binary strings of length k without consecutive ones.
	// fib[0] = 1 (represents the empty string, or base for length 0)
	// fib[1] = 2 (0, 1)
	// fib[k] = fib[k-1] + fib[k-2] for k >= 2
	// This sequence is 1, 2, 3, 5, 8, ... which corresponds to Fibonacci numbers.
	// Max n is 10^9, which is about 30 bits. So max index needed is around 30.
	// An array of size 32 (indices 0 to 31) is sufficient.
	fib := make([]int, 32)
	fib[0] = 1
	fib[1] = 2
	for i := 2; i < 32; i++ {
		fib[i] = fib[i-1] + fib[i-2]
	}

	ans := 0
	// L is the number of bits in n.
	// For n=0, L=0. For n=1 (binary 1), L=1. For n=5 (binary 101), L=3.
	L := bits.Len(uint(n))

	prevBitWasOne := false
	// Iterate from the most significant bit (L-1) down to the least significant bit (0).
	for i := L - 1; i >= 0; i-- {
		// Get the current bit of n at position i
		currentBit := (n >> i) & 1

		if currentBit == 1 {
			// If the current bit of n is 1, we can count all numbers that have a prefix
			// identical to n's prefix up to this point, but with the current bit set to 0.
			// For example, if n is 10110 and we are at the first 1 (MSB, bit 4):
			// We add fib[4] to ans. These are numbers like 0xxxx (where xxxx is a valid 4-bit sequence).
			// When we are at the second 1 (bit 2):
			// n is 10110. Prefix is 10. Current bit is 1.
			// We add fib[2] to ans. These are numbers like 100xx (where xx is a valid 2-bit sequence).
			// The count of valid suffixes of length i (for the '0' branch) is fib[i].
			ans += fib[i]

			// Check if n itself has consecutive ones up to this point
			if prevBitWasOne {
				// If the previous bit was also 1, then n's binary representation
				// contains "11". This means n itself is an invalid number.
				// We have already counted all valid numbers smaller than n.
				// We cannot form any more valid numbers by extending n's prefix
				// (because n itself is invalid from this point, and any number
				// with this prefix will also be invalid or larger than n).
				// So, we break the loop and return the current ans.
				return ans
			}
			prevBitWasOne = true
		} else { // currentBit == 0
			// If the current bit of n is 0, we can only continue by keeping this bit 0.
			// No new numbers are added to ans at this step, as changing this bit to 1
			// would make the number larger than n (if we are in the 'tight' prefix)
			// or would have been covered by a previous '0' branch.
			// Reset prevBitWasOne as we just saw a 0.
			prevBitWasOne = false
		}
	}

	// If the loop completes without breaking, it means n itself is a valid number
	// (i.e., it does not contain consecutive ones).
	// We need to include n in the count.
	ans++

	return ans
}