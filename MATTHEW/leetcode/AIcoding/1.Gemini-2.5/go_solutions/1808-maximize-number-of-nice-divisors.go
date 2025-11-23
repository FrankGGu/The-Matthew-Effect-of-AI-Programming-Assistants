func maxNiceDivisors(primeFactors int) int {
	MOD := 1_000_000_007

	if primeFactors <= 3 {
		return primeFactors
	}

	pow := func(base, exp int) int {
		res := 1
		base %= MOD
		for exp > 0 {
			if exp%2 == 1 {
				res = (res * base) % MOD
			}
			base = (base * base) % MOD
			exp /= 2
		}
		return res
	}

	if primeFactors%3 == 0 {
		return pow(3, primeFactors/3)
	} else if primeFactors%3 == 1 {
		return (pow(3, (primeFactors-4)/3) * 4) % MOD
	} else { // primeFactors % 3 == 2
		return (pow(3, (primeFactors-2)/3) * 2) % MOD
	}
}