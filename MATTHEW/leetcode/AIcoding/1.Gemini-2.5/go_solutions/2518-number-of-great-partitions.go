package main

import (
	"fmt"
)

func greatPartitions(nums []int, k int) int {
	MOD := 1_000_000_007

	totalSum := 0
	for _, num := range nums {
		totalSum += num
	}

	// If the total sum of all elements is less than 2k,
	// it's impossible to have two non-empty partitions, each with sum at least k.
	if totalSum < 2*k {
		return 0
	}

	n := len(nums)

	// Calculate 2^n % MOD, which is the total number of subsets.
	pow2n := 1
	for i := 0; i < n; i++ {
		pow2n = (pow2n * 2) % MOD
	}

	// dp[s] will store the number of subsets that sum to 's'.
	// We are interested in subsets whose sum is less than k.
	// The maximum sum we need to track in the DP table is min(k-1, totalSum).
	// If k is very large (e.g., 10^9), a direct DP array of size k would be too big.
	// However, the effective maximum sum we can form is totalSum.
	// So, the DP table size should be min(k, totalSum + 1).
	// If k > totalSum, we only need to track sums up to totalSum.
	// If k <= totalSum, we track sums up to k-1.
	// The problem constraints imply that `k` will be small enough for the DP table
	// in test cases where `k <= totalSum`.
	dpSize := k
	if totalSum < k {
		dpSize = totalSum + 1
	}

	dp := make([]int, dpSize)
	dp[0] = 1 // One way to make sum 0 (the empty set)

	// Populate the dp table using a 0/1 knapsack-like approach.
	// dp[j] = number of subsets that sum to j.
	for _, num := range nums {
		// Iterate backwards to ensure each num is used at most once per subset.
		for j := dpSize - 1; j >= num; j-- {
			dp[j] = (dp[j] + dp[j-num]) % MOD
		}
	}

	// Calculate the number of non-empty subsets whose sum is less than k.
	// This is the sum of dp[i] for i from 1 to min(k-1, totalSum).
	// Since dpSize is min(k, totalSum + 1), we sum up to dpSize-1.
	invalidSubsetsSumLtK := 0
	for i := 1; i < dpSize; i++ {
		invalidSubsetsSumLtK = (invalidSubsetsSumLtK + dp[i]) % MOD
	}

	// Total number of ways to partition `nums` into two non-empty subarrays `nums1` and `nums2`
	// is 2^n - 2. (Subtract 2 for the cases where `nums1` or `nums2` is empty).
	totalNonEmptyPartitions := (pow2n - 2 + MOD) % MOD

	// Calculate the number of "bad" partitions.
	// A partition is "bad" if sum(nums1) < k OR sum(nums2) < k.
	// Since totalSum >= 2k, it's impossible for both sum(nums1) < k AND sum(nums2) < k simultaneously.
	// (If both were < k, then totalSum = sum(nums1) + sum(nums2) < k + k = 2k, contradicting totalSum >= 2k).
	// Therefore, the number of bad partitions is:
	// (Number of partitions where sum(nums1) < k) + (Number of partitions where sum(nums2) < k).
	// By symmetry, both terms are equal to `invalidSubsetsSumLtK`.
	// So, total bad partitions = 2 * invalidSubsetsSumLtK.
	totalBadPartitions := (2 * invalidSubsetsSumLtK) % MOD

	// The number of great partitions is (total non-empty partitions) - (total bad partitions).
	result := (totalNonEmptyPartitions - totalBadPartitions + MOD) % MOD

	return result
}