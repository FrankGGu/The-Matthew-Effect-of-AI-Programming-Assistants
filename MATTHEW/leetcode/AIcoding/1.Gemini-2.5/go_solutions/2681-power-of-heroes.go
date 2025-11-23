package main

import (
	"sort"
)

func sumOfPower(nums []int) int {
	sort.Ints(nums)

	const MOD = 1e9 + 7

	totalPower := 0
	// currentMinSumWeighted stores the sum of (nums[j] * 2^(i-1-j)) for j from 0 to i-1.
	// This represents the sum of minimums for subsequences where nums[i] is the maximum,
	// and nums[j] (j < i) is the minimum, weighted by the number of ways to choose
	// elements between nums[j] and nums[i].
	currentMinSumWeighted := 0

	for _, num := range nums {
		// Calculate num^2 % MOD
		numSq := (num * num) % MOD

		// The term (currentMinSumWeighted + num) represents the sum of all possible minimums
		// for subsequences where 'num' is the maximum element.
		//
		// For j < i: nums[j] is the minimum, num is the maximum.
		// There are (i - 1 - (j + 1) + 1) = (i - j - 1) elements strictly between nums[j] and num.
		// Each of these can either be included or not, leading to 2^(i-j-1) ways.
		// The sum of (nums[j] * 2^(i-j-1)) for j < i is stored in currentMinSumWeighted.
		//
		// For j = i: num is both the minimum and maximum. This forms the subsequence [num].
		// Its minimum contribution is simply 'num'.
		//
		// So, (currentMinSumWeighted + num) correctly sums up these minimum contributions.
		term := (currentMinSumWeighted + num) % MOD

		// The power for subsequences where 'num' is the maximum is (num^2 * term).
		contribution := (numSq * term) % MOD

		totalPower = (totalPower + contribution) % MOD

		// Update currentMinSumWeighted for the next iteration (i+1).
		// If currentMinSumWeighted at index i is S_i = sum(nums[j] * 2^(i-1-j)) for j from 0 to i-1.
		// Then for index i+1, we need S_{i+1} = sum(nums[j] * 2^(i-j)) for j from 0 to i.
		// S_{i+1} = 2 * (sum(nums[j] * 2^(i-1-j))) + nums[i] * 2^0
		// S_{i+1} = 2 * S_i + nums[i]
		currentMinSumWeighted = (currentMinSumWeighted * 2) % MOD
		currentMinSumWeighted = (currentMinSumWeighted + num) % MOD
	}

	return totalPower
}