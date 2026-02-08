package main

func power(base, exp, modulus int) int {
	res := 1
	base %= modulus
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % modulus
		}
		base = (base * base) % modulus
		exp /= 2
	}
	return res
}

func numberOfCollisions(n int) int {
	mod := 1_000_000_007

	totalPatterns := power(2, n, mod)

	result := (totalPatterns - 2 + mod) % mod

	return result
}