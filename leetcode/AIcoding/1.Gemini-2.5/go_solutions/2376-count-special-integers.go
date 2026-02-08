package main

import (
	"strconv"
)

func countSpecialIntegers(n int) int {
	s := strconv.Itoa(n)
	lenS := len(s)

	// memo[idx][mask][tight][isStarted] stores the result of dp for given parameters.
	// idx: current digit position we are considering (from left to right, 0 to lenS-1).
	// mask: a bitmask representing digits already used in the current number being formed.
	// tight: a boolean indicating if we are restricted by the digits of 'n'.
	//        If true, the current digit can go up to s[idx]. If false, it can go up to 9.
	// isStarted: a boolean indicating if we have placed at least one non-zero digit.
	//            If false, we are currently placing leading zeros or haven't started.
	//            If true, we are forming a positive number.
	memo := make([][][][]int, lenS)
	for i := range memo {
		memo[i] = make([][][]int, 1<<10) // 1<<10 for 10 digits (0-9)
		for j := range memo[i] {
			memo[i][j] = make([][]int, 2) // 2 states for tight (true/false)
			for k := range memo[i][j] {
				memo[i][j][k] = make([]int, 2) // 2 states for isStarted (true/false)
				for l := range memo[i][j][k] {
					memo[i][j][k][l] = -1 // Initialize with -1 to indicate not computed
				}
			}
		}
	}

	var dp func(idx int, mask int, tight bool, isStarted bool) int
	dp = func(idx int, mask int, tight bool, isStarted bool) int {
		// Base case: If we have processed all digits, we have successfully formed a number.
		// This counts 0 as well if only leading zeros were placed, which will be adjusted later.
		if idx == lenS {
			return 1
		}

		// Convert booleans to integers for memoization table indexing.
		tightInt := 0
		if tight {
			tightInt = 1
		}
		isStartedInt := 0
		if isStarted {
			isStartedInt = 1
		}

		// Check memoization table
		if memo[idx][mask][tightInt][isStartedInt] != -1 {
			return memo[idx][mask][tightInt][isStartedInt]
		}

		ans := 0
		upperBound := 9
		if tight {
			upperBound = int(s[idx] - '0')
		}

		for d := 0; d <= upperBound; d++ {
			if isStarted { // We are currently forming a non-zero number
				// Check if digit 'd' has already been used
				if (mask>>d)&1 == 0 { // Digit 'd' is unique
					ans += dp(idx+1, mask|(1<<d), tight && (d == upperBound), true)
				}
			} else { // We are in the leading zero state (haven't placed a non-zero digit yet)
				if d == 0 { // Continue placing leading zeros
					ans += dp(idx+1, mask, tight && (d == upperBound), false)
				} else { // Placed the first non-zero digit
					// When d > 0 and isStarted is false, the mask must be 0.
					// So, (mask>>d)&1 == 0 is always true.
					ans += dp(idx+1, mask|(1<<d), tight && (d == upperBound), true)
				}
			}
		}

		// Store result in memoization table
		memo[idx][mask][tightInt][isStartedInt] = ans
		return ans
	}

	// The dp function counts numbers from 0 to n (inclusive) that have unique digits.
	// The problem asks for positive integers, so we subtract 1 for the number 0.
	return dp(0, 0, true, false) - 1
}