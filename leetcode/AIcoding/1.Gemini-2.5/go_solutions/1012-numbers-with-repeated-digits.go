import "strconv"

func numDupDigitsAtMostN(N int) int {
	sN := strconv.Itoa(N)
	L := len(sN)

	// memo[idx][mask][isTight][isLeadingZero]
	// idx: current digit position (0 to L-1)
	// mask: bitmask of digits used so far (0-9)
	// isTight: boolean, true if we are restricted by the digits of N
	// isLeadingZero: boolean, true if we are currently placing leading zeros
	memo := make([][1 << 10][2][2]int, L)
	for i := range memo {
		for j := range memo[i] {
			for k := range memo[i][j] {
				for l := range memo[i][j][k] {
					memo[i][j][k][l] = -1 // Initialize with -1 to indicate not computed
				}
			}
		}
	}

	var dp func(idx int, mask int, isTight bool, isLeadingZero bool) int
	dp = func(idx int, mask int, isTight bool, isLeadingZero bool) int {
		if idx == L {
			// If we've successfully formed a number, count it.
			// This base case implicitly handles '0' as a valid number with distinct digits.
			return 1
		}

		// Convert bools to int for memoization key
		it := 0
		if isTight {
			it = 1
		}
		ilz := 0
		if isLeadingZero {
			ilz = 1
		}

		if memo[idx][mask][it][ilz] != -1 {
			return memo[idx][mask][it][ilz]
		}

		ans := 0
		upperBound := 9
		if isTight {
			upperBound = int(sN[idx] - '0')
		}

		for digit := 0; digit <= upperBound; digit++ {
			if isLeadingZero {
				if digit == 0 { // Still placing leading zeros
					ans += dp(idx+1, mask, isTight && (digit == upperBound), true)
				} else { // First non-zero digit
					// Check if digit is already used (mask should be 0 here, so this check is always true for the first non-zero digit)
					if (mask & (1 << digit)) == 0 { // Digit not used yet
						ans += dp(idx+1, mask|(1<<digit), isTight && (digit == upperBound), false)
					}
				}
			} else { // Not placing leading zeros, regular number formation
				if (mask & (1 << digit)) == 0 { // Digit not used yet
					ans += dp(idx+1, mask|(1<<digit), isTight && (digit == upperBound), false)
				}
			}
		}

		memo[idx][mask][it][ilz] = ans
		return ans
	}

	// Call DP to count numbers with distinct digits in range [0, N]
	countDistinctDigits := dp(0, 0, true, true)

	// The DP counts '0' as a number with distinct digits.
	// The problem asks for numbers in [1, N].
	// So, subtract 1 from countDistinctDigits to exclude '0'.
	// Then, the answer is N - (count of numbers with distinct digits in [1, N]).
	return N - (countDistinctDigits - 1)
}