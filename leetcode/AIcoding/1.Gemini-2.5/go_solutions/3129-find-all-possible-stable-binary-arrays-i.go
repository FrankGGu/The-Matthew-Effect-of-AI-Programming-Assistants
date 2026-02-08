package main

func numberOfStableArrays(zero int, one int, limit int) int {
	const MOD = 1_000_000_007

	// dp[i][j][0] stores the number of stable binary arrays with 'i' zeros and 'j' ones,
	// where the array ends with a block of zeros.
	// dp[i][j][1] stores the number of stable binary arrays with 'i' zeros and 'j' ones,
	// where the array ends with a block of ones.
	dp := make([][][2]int, zero+1)
	for i := range dp {
		dp[i] = make([][2]int, one+1)
	}

	// Base cases: Arrays consisting only of zeros or only of ones.
	// An array of 'k' zeros (e.g., "000") is stable if k <= limit.
	// An array of 'k' ones (e.g., "111") is stable if k <= limit.
	// These are counted as ending with 0 or 1 respectively.
	for k := 1; k <= limit; k++ {
		if k <= zero {
			dp[k][0][0] = 1 // Array of k zeros, e.g., "0", "00", ..., "0...0" (k times)
		}
		if k <= one {
			dp[0][k][1] = 1 // Array of k ones, e.g., "1", "11", ..., "1...1" (k times)
		}
	}

	// Fill the DP table for combinations of 'i' zeros and 'j' ones.
	// The loops start from 1 because arrays with 0 zeros or 0 ones (but not both)
	// are handled by the base cases.
	for i := 1; i <= zero; i++ {
		for j := 1; j <= one; j++ {
			// Calculate dp[i][j][0]: arrays ending with a block of zeros.
			// This can be formed by:
			// 1. Appending a '0' to an array (i-1 zeros, j ones) that ends with a '0'.
			//    This extends the current block of zeros.
			// 2. Appending a '0' to an array (i-1 zeros, j ones) that ends with a '1'.
			//    This starts a new block of zeros.
			//
			// The recurrence relation for dp[i][j][0] (sum of ways to add k zeros after a '1') is:
			// dp[i][j][0] = (dp[i-1][j][0] + dp[i-1][j][1] - dp[i-limit-1][j][1] + MOD) % MOD
			//
			// Explanation:
			// - `dp[i-1][j][0]` represents all arrays with `i-1` zeros and `j` ones ending with a zero.
			//   When we add another zero, these arrays will now have `i` zeros and `j` ones, ending with a zero.
			//   This term accounts for extending blocks of zeros.
			// - `dp[i-1][j][1]` represents all arrays with `i-1` zeros and `j` ones ending with a one.
			//   When we add a zero, these arrays will now have `i` zeros and `j` ones, ending with a zero (starting a new block).
			//   This term accounts for starting new blocks of zeros.
			// - `dp[i-limit-1][j][1]` is subtracted to handle the `limit` constraint.
			//   If `i-limit-1 >= 0`, `dp[i-limit-1][j][1]` represents arrays with `i-limit-1` zeros and `j` ones ending with a one.
			//   If we were to append `limit+1` zeros to these arrays, it would violate the `limit` constraint.
			//   The `dp[i-limit-1][j][1]` term effectively "removes" the contribution from arrays that would exceed the limit
			//   when extending a block of zeros that started after a '1'.
			//   The `+ MOD` ensures the result remains positive before the final modulo.
			dp[i][j][0] = (dp[i-1][j][0] + dp[i-1][j][1]) % MOD
			if i-limit-1 >= 0 {
				dp[i][j][0] = (dp[i][j][0] - dp[i-limit-1][j][1] + MOD) % MOD
			}

			// Calculate dp[i][j][1]: arrays ending with a block of ones.
			// This is symmetric to the calculation for dp[i][j][0].
			dp[i][j][1] = (dp[i][j-1][1] + dp[i][j-1][0]) % MOD
			if j-limit-1 >= 0 {
				dp[i][j][1] = (dp[i][j][1] - dp[i][j-limit-1][0] + MOD) % MOD
			}
		}
	}

	// The total number of stable arrays with 'zero' zeros and 'one' ones
	// is the sum of arrays ending with 0 and arrays ending with 1.
	ans := (dp[zero][one][0] + dp[zero][one][1]) % MOD
	return ans
}