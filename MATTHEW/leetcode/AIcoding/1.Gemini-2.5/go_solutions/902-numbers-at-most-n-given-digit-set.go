package main

import (
	"strconv"
	"math"
)

func atMostNGivenDigitSet(digits []string, n int) int {
	s := strconv.Itoa(n)
	L := len(s)
	numDigits := len(digits)

	count := 0

	// Part 1: Count numbers with fewer digits than N
	// For each length from 1 to L-1, any digit can be placed at any position.
	for i := 1; i < L; i++ {
		count += int(math.Pow(float64(numDigits), float64(i)))
	}

	// Part 2: Count numbers with the same number of digits as N
	// Iterate through the digits of N from left to right.
	isPrefixMatch := true // Flag to track if the current prefix matches a prefix of N
	for i := 0; i < L; i++ {
		hasEqualDigit := false // Flag to check if N's i-th digit can be matched by a digit from 'digits'

		for _, dStr := range digits {
			dChar := dStr[0] // Get the character representation of the digit

			if dChar < s[i] {
				// If a digit from 'digits' is smaller than N's current digit,
				// then any combination of 'numDigits' for the remaining L-1-i positions
				// will result in a number smaller than N.
				count += int(math.Pow(float64(numDigits), float64(L-1-i)))
			} else if dChar == s[i] {
				// If a digit from 'digits' is equal to N's current digit,
				// we continue to the next position to potentially form N itself or a prefix of N.
				hasEqualDigit = true
			} else { // dChar > s[i]
				// If a digit from 'digits' is greater than N's current digit,
				// we cannot use this digit or any subsequent digits (since 'digits' is sorted)
				// for this position if we want to form a number <= N.
				break 
			}
		}

		if !hasEqualDigit {
			// If no digit in 'digits' was equal to s[i],
			// it means we cannot form a number with the current prefix that is <= N.
			// So, stop processing further positions for this path.
			isPrefixMatch = false
			break
		}
	}

	// If after checking all digits, the prefix still matches (meaning N itself could be formed),
	// add N to the count.
	if isPrefixMatch {
		count++
	}

	return count
}