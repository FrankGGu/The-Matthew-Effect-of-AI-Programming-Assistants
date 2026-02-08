func maxNiceDivisors(primeFactors int) int {
	if primeFactors <= 3 {
		return primeFactors
	}
	mod := 1000000007
	if primeFactors%3 == 0 {
		return pow(3, primeFactors/3, mod)
	} else if primeFactors%3 == 1 {
		return (pow(3, (primeFactors-4)/3, mod) * 4) % mod
	} else {
		return (pow(3, (primeFactors-2)/3, mod) * 2) % mod
	}
}

func pow(base, exp, mod int) int {
	res := 1
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