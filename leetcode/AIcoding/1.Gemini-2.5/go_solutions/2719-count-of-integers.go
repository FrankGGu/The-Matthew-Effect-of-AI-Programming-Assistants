package main

const MOD = 1e9 + 7

func countS(num1 string, num2 string, min_sum int, max_sum int) int {

	var dp func(s string, minS, maxS int) int
	dp = func(s string, minS, maxS int) int {
		n := len(s)

		// memoLocal[idx][currentSum][isTight][isLeadingZero]
		// idx: current digit position (0 to n-1)
		// currentSum: sum of digits so far (0 to maxS)
		// isTight: boolean, true if we are restricted by the digits of s
		// isLeadingZero: boolean, true if we are currently placing leading zeros
		// Dimensions: (n+1) for idx, (maxS+1) for currentSum, 2 for isTight, 2 for isLeadingZero
		memoLocal := make([][][2][2]int, n+1)
		for i := range memoLocal {
			memoLocal[i] = make([][2][2]int, maxS+1)
			for j := range memoLocal[i] {
				memoLocal[i][j][0][0] = -1
				memoLocal[i][j][0][1] = -1
				memoLocal[i][j][1][0] = -1
				memoLocal[i][j][1][1] = -1
			}
		}

		var solveRec func(idx, currentSum int, isTight, isLeadingZero bool) int
		solveRec = func(idx, currentSum int, isTight, isLeadingZero bool) int {
			// Pruning: if current sum already exceeds maxS, no valid numbers can be formed.
			if currentSum > maxS {
				return 0
			}
			// Base case: all digits processed
			if idx == n {
				// Check if the final sum is within the valid range
				if currentSum >= minS {
					return 1
				}
				return 0
			}

			// Convert boolean states to int for memoization table indexing
			tightInt := 0
			if isTight {
				tightInt = 1
			}
			leadingZeroInt := 0
			if isLeadingZero {
				leadingZeroInt = 1
			}

			// Check memoization table
			if memoLocal[idx][currentSum][tightInt][leadingZeroInt] != -1 {
				return memoLocal[idx][currentSum][tightInt][leadingZeroInt]
			}

			res := 0
			// Determine the upper bound for the current digit
			upperBound := 9
			if isTight {
				upperBound = int(s[idx] - '0')
			}

			// Iterate through possible digits
			for digit := 0; digit <= upperBound; digit++ {
				if isLeadingZero && digit == 0 {
					// If we are still placing leading zeros and the current digit is 0,
					// the sum doesn't change, and we remain in the leading zero state.
					res = (res + solveRec(idx+1, currentSum, isTight && (digit == upperBound), true)) % MOD
				} else {
					// If we place a non-zero digit (or are past leading zeros),
					// update the sum and transition out of the leading zero state.
					res = (res + solveRec(idx+1, currentSum+digit, isTight && (digit == upperBound), false)) % MOD
				}
			}

			// Store result in memoization table
			memoLocal[idx][currentSum][tightInt][leadingZeroInt] = res
			return res
		}

		// Start the recursion from the first digit (idx 0), with current sum 0,
		// tight constraint true (restricted by s), and in leading zero state.
		return solveRec(0, 0, true, true)
	}

	// Calculate count of numbers from 0 to num2 (inclusive)
	ans2 := dp(num2, min_sum, max_sum)
	// Calculate count of numbers from 0 to num1 (exclusive, effectively num1-1)
	ans1 := dp(num1, min_sum, max_sum)

	// The result is count(num2) - count(num1-1).
	// This is commonly implemented as count(num2) - count(num1) + check(num1).
	// Where check(num1) determines if num1 itself satisfies the digit sum condition.
	result := (ans2 - ans1 + MOD) % MOD // Add MOD before taking modulo to handle negative results

	// Check if num1 itself satisfies the condition
	sumNum1 := 0
	for _, r := range num1 {
		sumNum1 += int(r - '0')
	}
	if sumNum1 >= min_sum && sumNum1 <= max_sum {
		result = (result + 1) % MOD // Add 1 if num1 is valid, as it was subtracted by ans1
	}

	return result
}