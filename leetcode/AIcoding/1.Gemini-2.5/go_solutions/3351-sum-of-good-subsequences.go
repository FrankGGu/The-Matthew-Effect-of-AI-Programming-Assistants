package main

import (
	"sort"
)

const MOD = 1e9 + 7

type FenwickTree []int

func NewFenwickTree(size int) FenwickTree {
	return make(FenwickTree, size+1)
}

func (ft FenwickTree) Update(idx, val int) {
	idx++ // Convert to 1-indexed
	for idx < len(ft) {
		ft[idx] = (ft[idx] + val) % MOD
		idx += idx & (-idx)
	}
}

func (ft FenwickTree) Query(idx int) int {
	idx++ // Convert to 1-indexed
	sum := 0
	for idx > 0 {
		sum = (sum + ft[idx]) % MOD
		idx -= idx & (-idx)
	}
	return sum
}

func sumOfGoodSubsequences(nums []int, k int) int {
	// Coordinate compression: Map original values to 0-indexed ranks
	uniqueValsMap := make(map[int]struct{})
	for _, num := range nums {
		uniqueValsMap[num] = struct{}{}
	}

	sortedUnique := make([]int, 0, len(uniqueValsMap))
	for val := range uniqueValsMap {
		sortedUnique = append(sortedUnique, val)
	}
	sort.Ints(sortedUnique)

	valToRank := make(map[int]int)
	for i, val := range sortedUnique {
		valToRank[val] = i // 0-indexed rank
	}

	numUnique := len(sortedUnique)

	// dp[j] will be a Fenwick tree storing sums for subsequences of length j.
	// dp[j].Query(rank) returns the sum of f(subsequence) for all good subsequences
	// of length j ending with a value whose rank is less than or equal to 'rank'.
	bit := make([]FenwickTree, k+1)
	for j := 1; j <= k; j++ {
		bit[j] = NewFenwickTree(numUnique)
	}

	for _, num := range nums {
		rank := valToRank[num]
		currentTerm := (num + 1) % MOD

		// Iterate for lengths from 1 to k.
		// For each length j, we extend subsequences of length j-1.
		for j := 1; j <= k; j++ {
			prevSum := 0
			if j == 1 {
				// Base case: for length 1, the "previous product" is 1 (representing an empty prefix product).
				prevSum = 1
			} else {
				// Query sum of f(subsequence) for length j-1 ending at values strictly less than num.
				// rank - 1 ensures we only consider values smaller than the current num.
				prevSum = bit[j-1].Query(rank - 1)
			}

			// Calculate the new contribution for subsequences of length j ending with current num.
			// This is (sum of previous products) * (current_num + 1).
			addVal := (prevSum * currentTerm) % MOD

			// Add this contribution to the Fenwick tree for length j at the current rank.
			bit[j].Update(rank, addVal)
		}
	}

	// The total sum of values of all good subsequences of length k is the sum
	// of all contributions for length k across all possible ending values.
	// This is obtained by querying the Fenwick tree for length k up to the maximum rank.
	return bit[k].Query(numUnique - 1)
}