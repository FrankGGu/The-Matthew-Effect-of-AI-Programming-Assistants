func countGoodNumbers(n int64) int {
	const MOD int64 = 1e9 + 7

	// power calculates (base^exp) % mod
	power := func(base, exp, mod int64) int64 {
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

	// Number of positions that must be even (0, 2, 4, ...)
	// These are indices 0, 2, ..., n-1 if n is odd, or n-2 if n is even.
	// This count is equivalent to ceil(n/2) or n/2 + n%2.
	evenDigitPositions := n/2 + n%2

	// Number of positions that must be prime (1, 3, 5, ...)
	// These are indices 1, 3, ..., n-2 if n is odd, or n-1 if n is even.
	// This count is equivalent to floor(n/2) or n/2.
	primeDigitPositions := n / 2

	// Calculate 5 raised to the power of evenDigitPositions, modulo MOD
	count5 := power(5, evenDigitPositions, MOD)

	// Calculate 4 raised to the power of primeDigitPositions, modulo MOD
	count4 := power(4, primeDigitPositions, MOD)

	// The total number of good numbers is the product of these two counts, modulo MOD
	ans := (count5 * count4) % MOD

	return int(ans)
}