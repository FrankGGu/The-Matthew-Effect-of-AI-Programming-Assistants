package main

const MOD = 1e9 + 7
const MAX_COMB_N = 10014 // Max n (10^4) + max exponent for 2 (13) - 1 + a bit extra for safety
                          // Max value for (a + n - 1) is (13 + 10000 - 1) = 10012.

var fact []int
var invFact []int

func powMod(base, exp int) int {
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

func invMod(n int) int {
	return powMod(n, MOD-2)
}

func precomputeFactorials() {
	fact = make([]int, MAX_COMB_N+1)
	invFact = make([]int, MAX_COMB_N+1)
	fact[0] = 1
	invFact[0] = 1
	for i := 1; i <= MAX_COMB_N; i++ {
		fact[i] = (fact[i-1] * i) % MOD
	}
	invFact[MAX_COMB_N] = invMod(fact[MAX_COMB_N])
	for i := MAX_COMB_N - 1; i >= 1; i-- {
		invFact[i] = (invFact[i+1] * (i + 1)) % MOD
	}
}

func nCrMod(n, r int) int {
	if r < 0 || r > n {
		return 0
	}
	return (((fact[n] * invFact[r]) % MOD) * invFact[n-r]) % MOD
}

func waysToCreateProduct(queries [][]int) []int {
	precomputeFactorials()

	results := make([]int, len(queries))

	for i, query := range queries {
		n := query[0]
		k := query[1]

		currentWays := 1
		tempK := k

		for p := 2; p*p <= tempK; p++ {
			if tempK%p == 0 {
				count := 0
				for tempK%p == 0 {
					count++
					tempK /= p
				}
				currentWays = (currentWays * nCrMod(count+n-1, n-1)) % MOD
			}
		}

		if tempK > 1 {
			currentWays = (currentWays * nCrMod(1+n-1, n-1)) % MOD
		}
		results[i] = currentWays
	}

	return results
}