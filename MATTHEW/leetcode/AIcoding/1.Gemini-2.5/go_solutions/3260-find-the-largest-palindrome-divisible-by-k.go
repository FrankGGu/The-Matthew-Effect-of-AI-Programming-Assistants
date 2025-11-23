package main

import (
	"math"
	"strconv"
)

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

func largestPalindrome(n int, k int) int {
	if n == 1 {
		// For n=1, the largest 1-digit palindromes are 9, 8, ..., 1.
		// We need the largest one divisible by k.
		for i := 9; i >= 1; i-- {
			if i%k == 0 {
				return i % 1337
			}
		}
		return 0 // Should not be reached for typical problem constraints (e.g., k=1 always returns 9)
	}

	// Calculate the upper and lower bounds for n-digit numbers.
	// For n=2, upperBound = 99, lowerBound = 10.
	upperBound := int64(math.Pow10(n)) - 1
	lowerBound := int64(math.Pow10(n - 1))

	// Iterate from the largest possible first half of a palindrome downwards.
	// This generates palindromes in decreasing order of magnitude.
	for i := upperBound; i >= lowerBound; i-- {
		// Construct the palindrome `p` from `i`.
		// For n=2, if i=99, s="99", pStr="99"+"99"="9999".
		// If i=98, s="98", pStr="98"+"89"="9889".
		s := strconv.FormatInt(i, 10)
		pStr := s + reverseString(s)
		p, _ := strconv.ParseInt(pStr, 10, 64)

		// Check if the constructed palindrome `p` is divisible by `k`.
		if p%int64(k) == 0 {
			// If it is, now check if `p` can be formed by the product of two n-digit numbers.
			// We need to find a factor `j` such that `lowerBound <= j <= upperBound`
			// and `p/j` is also within `lowerBound <= p/j <= upperBound`.
			// The loop for `j` iterates from `upperBound` downwards.
			for j := upperBound; j >= lowerBound; j-- {
				// Optimization: if j*j < p, then j is too small to be the larger factor.
				// Any remaining `j` values would be smaller than `sqrt(p)`,
				// meaning `p/j` would be larger than `sqrt(p)`.
				// If `p/j` is an n-digit factor, it would have been encountered as `j` in a previous iteration
				// (when `j` was larger than `sqrt(p)`).
				if j*j < p {
					break
				}

				if p%j == 0 {
					otherFactor := p / j
					// Check if the `otherFactor` is also an n-digit number.
					if otherFactor >= lowerBound && otherFactor <= upperBound {
						// Found factors for `p` within the n-digit range, and `p` is divisible by `k`.
						// Since we are generating `p` in decreasing order, the first one found is the largest.
						return int(p % 1337)
					}
				}
			}
		}
	}

	return 0 // Should not be reached based on typical problem guarantees that a solution exists.
}