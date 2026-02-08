func countGoodNumbers(n int64) int {
	mod := 1000000007
	return int(pow(5, (n+1)/2, mod) * pow(4, n/2, mod) % mod)
}

func pow(base int64, exp int64, mod int) int64 {
	res := int64(1)
	base %= int64(mod)
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % int64(mod)
		}
		base = (base * base) % int64(mod)
		exp /= 2
	}
	return res
}