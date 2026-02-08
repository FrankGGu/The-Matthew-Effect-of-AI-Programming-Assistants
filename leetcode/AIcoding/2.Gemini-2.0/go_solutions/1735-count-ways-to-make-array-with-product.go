func waysToFillArray(queries [][]int) []int {
	const mod = 1000000007

	maxN := 0
	for _, q := range queries {
		if q[0] > maxN {
			maxN = q[0]
		}
	}

	fact := make([]int, maxN+5)
	inv := make([]int, maxN+5)
	fact[0] = 1
	inv[0] = 1
	for i := 1; i <= maxN+4; i++ {
		fact[i] = (fact[i-1] * i) % mod
		inv[i] = pow(fact[i], mod-2, mod)
	}

	combinations := func(n, k int) int {
		if k < 0 || k > n {
			return 0
		}
		return (((fact[n] * inv[k]) % mod) * inv[n-k]) % mod
	}

	pow := func(base, exp, m int) int {
		res := 1
		base %= m
		for exp > 0 {
			if exp%2 == 1 {
				res = (res * base) % m
			}
			base = (base * base) % m
			exp /= 2
		}
		return res
	}

	ans := make([]int, len(queries))
	for i, q := range queries {
		n := q[0]
		k := q[1]

		factors := make(map[int]int)
		d := 2
		tempK := k
		for d*d <= tempK {
			for tempK%d == 0 {
				factors[d]++
				tempK /= d
			}
			d++
		}
		if tempK > 1 {
			factors[tempK]++
		}

		res := 1
		for _, count := range factors {
			res = (res * combinations(n+count-1, count)) % mod
		}
		ans[i] = res
	}
	return ans
}