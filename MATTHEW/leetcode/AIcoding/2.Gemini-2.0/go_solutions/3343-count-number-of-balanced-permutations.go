func countBalancedPermutations(n int) int {
	mod := int(1e9 + 7)
	fact := make([]int, n+1)
	fact[0] = 1
	for i := 1; i <= n; i++ {
		fact[i] = (fact[i-1] * i) % mod
	}

	pow := func(a, b int) int {
		res := 1
		for b > 0 {
			if b%2 == 1 {
				res = (res * a) % mod
			}
			a = (a * a) % mod
			b /= 2
		}
		return res
	}

	inv := func(a int) int {
		return pow(a, mod-2)
	}

	comb := func(n, k int) int {
		if k < 0 || k > n {
			return 0
		}
		num := fact[n]
		den := (fact[k] * fact[n-k]) % mod
		return (num * inv(den)) % mod
	}

	return (comb(n, n/2) * inv(n/2+1)) % mod
}