package main

import (
	"strconv"
)

func power(base, exp, mod int64) int64 {
	res := int64(1)
	base %= mod
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % mod
		}
		base = (base * base) % mod
		exp /= 2
	}
	return res
}

func millerRabin(n int64) bool {
	if n < 2 {
		return false
	}
	if n == 2 || n == 3 {
		return true
	}
	if n%2 == 0 {
		return false
	}

	// Find r and d such that n = 2^r * d + 1 with d odd
	d := n - 1
	for d%2 == 0 {
		d /= 2
	}

	// Bases for deterministic Miller-Rabin for numbers up to 3,825,123,056,546,413,051
	// (which is ~3.8 * 10^18). A 15-digit number is less than 10^15, so these are sufficient.
	bases := []int64{2, 3, 5, 7, 11, 13, 17, 19, 23}

	for _, a := range bases {
		if a >= n { // If base is >= n, it's not a valid test base for n.
			// This can happen for small n (e.g., n=5, a=7).
			// We can skip or break if bases are sorted.
			continue
		}

		x := power(a, d, n)
		if x == 1 || x == n-1 {
			continue
		}

		flag := false
		tempD := d
		for tempD != n-1 {
			x = (x * x) % n
			tempD *= 2
			if x == 1 {
				return false // n is composite
			}
			if x == n-1 {
				flag = true
				break
			}
		}
		if !flag {
			return false // n is composite
		}
	}
	return true // n is prime
}

func sumOfLargestPrimeSubstrings(s string) int64 {
	n := len(s)
	// dp[i] will store the maximum sum of prime substrings for the prefix s[0...i-1].
	// Initialize with -1 to indicate unreachable states, except dp[0].
	dp := make([]int64, n+1)
	for i := range dp {
		dp[i] = -1
	}
	dp[0] = 0 // Base case: an empty prefix has a sum of 0.

	for i := 1; i <= n; i++ {
		// Iterate through all possible starting points 'j' for the last substring s[j...i-1].
		// The substring s[j...i-1] has length (i-j).
		for j := 0; j < i; j++ {
			if dp[j] == -1 { // If the prefix s[0...j-1] is unreachable, we cannot extend from it.
				continue
			}

			subStr := s[j:i]

			// A number cannot have leading zeros unless it's "0" itself.
			// "0" is not prime, so we can skip any substring with a leading '0' if its length is > 1.
			if len(subStr) > 1 && subStr[0] == '0' {
				continue
			}

			num, err := strconv.ParseInt(subStr, 10, 64)
			if err != nil {
				// This error should not occur if the input string 's' contains only digits.
				continue
			}

			if millerRabin(num) {
				// If 'num' is prime, we can potentially update dp[i].
				// dp[i] = max(dp[i], dp[j] + num)
				if dp[i] == -1 || dp[j]+num > dp[i] {
					dp[i] = dp[j] + num
				}
			}
		}
	}

	// If dp[n] is -1, it means no valid partition of the entire string 's' into prime substrings was found.
	// In such cases, the problem usually expects a return value of 0.
	if dp[n] == -1 {
		return 0
	}
	return dp[n]
}