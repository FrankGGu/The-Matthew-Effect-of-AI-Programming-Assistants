func superPow(a int, b []int) int {
	MOD := 1337
	ans := 1
	for _, x := range b {
		ans = pow(ans, 10, MOD) * pow(a, x, MOD) % MOD
	}
	return ans
}

func pow(x, n, mod int) int {
	res := 1
	x %= mod
	for n > 0 {
		if n%2 == 1 {
			res = res * x % mod
		}
		x = x * x % mod
		n /= 2
	}
	return res
}