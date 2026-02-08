package main

import (
	"sort"
)

const MOD = 1_000_000_007

var comb [1001][1001]int
var precomputed bool

func init() {
	if !precomputed {
		for i := 0; i <= 1000; i++ {
			comb[i][0] = 1
			for j := 1; j <= i; j++ {
				comb[i][j] = (comb[i-1][j-1] + comb[i-1][j]) % MOD
			}
		}
		precomputed = true
	}
}

func findTheSumOfSubsequencePowers(nums []int, k int) int {
	sort.Ints(nums)
	n := len(nums)

	totalMinSum := 0

	for i := 0; i <= n-k; i++ {
		// For nums[i] to be the minimum element of a subsequence of length k,
		// we need to choose k-1 additional elements from the elements after nums[i].
		// The number of elements available after nums[i] is (n - 1) - i.
		// We need to choose k-1 elements from these available elements.
		// This is C(n - 1 - i, k - 1).

		// The loop condition i <= n-k ensures that n-1-i >= k-1,
		// so there are always enough elements to choose k-1 from,
		// and comb[n-1-i][k-1] will be a valid lookup.
		count := comb[n-1-i][k-1]

		// Add nums[i] * count to the total sum of minimums.
		// Apply modulo arithmetic at each step to prevent overflow.
		contribution := (nums[i] % MOD * count) % MOD
		totalMinSum = (totalMinSum + contribution) % MOD
	}

	// The problem asks for the sum of (min(s) * length_of_subsequence) for all subsequences s of length k.
	// Since length_of_subsequence is always k, this simplifies to k * sum(min(s)).
	// Ensure k is also taken modulo MOD before multiplication.
	result := (k % MOD * totalMinSum) % MOD

	return result
}