package main

import (
	"strconv"
)

var (
	s       string
	K_val   int
	memo    [][][2][2]int
)

func digitDP(idx int, currentSumModK int, isTight bool, isLeadingZero bool) int {
	if idx == len(s) {
		// If isLeadingZero is true, it means we formed the number 0.
		// The sum of digits of 0 is 0. 0 % K_val is 0 for any K_val > 0.
		// So, 0 is considered K-reducible by sum of digits.
		if isLeadingZero {
			return 1
		}
		if currentSumModK == 0 {
			return 1
		}
		return 0
	}

	tightInt := 0
	if isTight {
		tightInt = 1
	}
	leadingZeroInt := 0
	if isLeadingZero {
		leadingZeroInt = 1
	}

	if memo[idx][currentSumModK][tightInt][leadingZeroInt] != -1 {
		return memo[idx][currentSumModK][tightInt][leadingZeroInt]
	}

	ans := 0
	upperBound := 9
	if isTight {
		upperBound = int(s[idx] - '0')
	}

	for digit := 0; digit <= upperBound; digit++ {
		if isLeadingZero && digit == 0 { // Still forming leading zeros
			ans += digitDP(idx+1, 0, isTight && (digit == upperBound), true)
		} else { // Placed a non-zero digit, or it's not a leading zero position
			newSumModK := (currentSumModK + digit) % K_val
			ans += digitDP(idx+1, newSumModK, isTight && (digit == upperBound), false)
		}
	}

	memo[idx][currentSumModK][tightInt][leadingZeroInt] = ans
	return ans
}

func countKReducibleNumbers(n int, k int) int {
	// The problem asks for numbers LESS THAN N.
	// Digit DP typically counts numbers from 0 up to a given number (inclusive).
	// So, we count numbers from 0 up to N-1.
	if n <= 0 {
		return 0
	}

	s = strconv.Itoa(n - 1) // Convert N-1 to string of digits
	K_val = k

	// Initialize memo table with -1 (indicating uncomputed states)
	// Max length of N for typical LeetCode is around 18-19 digits (for 10^18)
	// Max sum of digits for 19 digits is 19*9 = 171. K_val is usually <= 171 for this problem type.
	// Assuming K_val is within a reasonable range (e.g., up to 200) for memoization.
	memo = make([][][2][2]int, len(s)+1)
	for i := range memo {
		memo[i] = make([][2][2]int, K_val) // K_val states for currentSumModK (0 to K_val-1)
		for j := range memo[i] {
			memo[i][j] = make([][2]int, 2) // 2 states for isTight (0 or 1)
			for l := range memo[i][j] {
				memo[i][j][l] = make([]int, 2) // 2 states for isLeadingZero (0 or 1)
				for m := range memo[i][j][l] {
					memo[i][j][l][m] = -1
				}
			}
		}
	}

	// Start the digit DP from the first digit, initial sum 0, tight constraint, and leading zeros allowed.
	return digitDP(0, 0, true, true)
}