const mod int = 1e9 + 7

func numberOfSequence(n int, sick []int) int {
	m := len(sick)
	healthy := n - m
	fact := make([]int, n+1)
	inv := make([]int, n+1)

	fact[0] = 1
	for i := 1; i <= n; i++ {
		fact[i] = (fact[i-1] * i) % mod
	}

	inv[n] = power(fact[n], mod-2)
	for i := n - 1; i >= 0; i-- {
		inv[i] = (inv[i+1] * (i + 1)) % mod
	}

	comb := func(n int, k int) int {
		if k < 0 || k > n {
			return 0
		}
		return (((fact[n] * inv[k]) % mod) * inv[n-k]) % mod
	}

	power := func(base int, exp int) int {
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

	return (((comb(healthy+1, m) * fact[m]) % mod) * power(2, healthy-1)) % mod
}