package main

const MOD = 1_000_000_007

var fact [1001]int

func init() {
	fact[0] = 1
	for i := 1; i <= 1000; i++ {
		fact[i] = (fact[i-1] * i) % MOD
	}
}

func power(base, exp, mod int) int {
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

func nCr_mod_p(n, r int) int {
	if r < 0 || r > n {
		return 0
	}
	if r == 0 || r == n {
		return 1
	}

	num := fact[n]
	den1 := fact[r]
	den2 := fact[n-r]

	invDen1 := power(den1, MOD-2, MOD)
	invDen2 := power(den2, MOD-2, MOD)

	res := (num * invDen1) % MOD
	res = (res * invDen2) % MOD
	return res
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func numberOfWays(startPos int, endPos int, k int) int {
	diff := endPos - startPos

	if (diff+k)%2 != 0 {
		return 0
	}

	if abs(diff) > k {
		return 0
	}

	x := (k + diff) / 2

	return nCr_mod_p(k, x)
}