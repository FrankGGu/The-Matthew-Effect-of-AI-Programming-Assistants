package main

import (
	"sort"
)

const MOD = 1_000_000_007

var fact []int
var invFact []int

func pow(base, exp int) int {
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

func inv(n int) int {
	return pow(n, MOD-2)
}

func precomputeFactorials(n int) {
	fact = make([]int, n+1)
	invFact = make([]int, n+1)
	fact[0] = 1
	invFact[0] = 1
	for i := 1; i <= n; i++ {
		fact[i] = (fact[i-1] * i) % MOD
		// invFact[i] = inv(fact[i]) // This is slow if computed for each i
	}
	// Compute all inverse factorials using inv(fact[n]) and working backwards
	invFact[n] = inv(fact[n])
	for i := n - 1; i >= 1; i-- {
		invFact[i] = (invFact[i+1] * (i + 1)) % MOD
	}
}

func nCr_mod_p(n, r int) int {
	if r < 0 || r > n {
		return 0
	}
	return (fact[n] * invFact[r] % MOD * invFact[n-r] % MOD)
}

func maximumSumOfSubsequences(nums []int, k int) int {
	N := len(nums)
	sort.Ints(nums)

	precomputeFactorials(N)

	// coeffs[x] = sum_{p=0 to k-1} C(x, p)
	// This represents the number of subsequences of length at most k,
	// that can be formed by choosing elements from a set of 'x' available elements.
	coeffs := make([]int, N)

	// Base case for x=0: sum_{p=0 to k-1} C(0,p)
	// Since k >= 1, k-1 >= 0. C(0,0) = 1. All other C(0,p) for p>0 are 0.
	coeffs[0] = 1 

	for i := 1; i < N; i++ {
		// Recurrence relation: coeffs[i] = (2 * coeffs[i-1] - C(i-1, k-1) + MOD) % MOD
		// This recurrence is derived from Pascal's identity and correctly handles
		// cases where C(i-1, k-1) is 0 (e.g., when k-1 > i-1).
		termToSubtract := nCr_mod_p(i-1, k-1)
		coeffs[i] = (2*coeffs[i-1] - termToSubtract + MOD) % MOD
	}

	totalSum := 0
	for i := 0; i < N; i++ {
		// Contribution of nums[i] as the maximum element:
		// For nums[i] to be the maximum, other elements must be chosen from nums[0...i-1].
		// There are 'i' elements available to choose from.
		// The number of ways to pick at most k-1 elements from these 'i' elements
		// (to form a subsequence of length at most k including nums[i]) is coeffs[i].
		termMax := (nums[i] * coeffs[i]) % MOD
		totalSum = (totalSum + termMax) % MOD

		// Contribution of nums[i] as the minimum element:
		// For nums[i] to be the minimum, other elements must be chosen from nums[i+1...N-1].
		// There are 'N-1-i' elements available to choose from.
		// The number of ways to pick at most k-1 elements from these 'N-1-i' elements
		// (to form a subsequence of length at most k including nums[i]) is coeffs[N-1-i].
		termMin := (nums[i] * coeffs[N-1-i]) % MOD
		totalSum = (totalSum + termMin) % MOD
	}

	return totalSum
}