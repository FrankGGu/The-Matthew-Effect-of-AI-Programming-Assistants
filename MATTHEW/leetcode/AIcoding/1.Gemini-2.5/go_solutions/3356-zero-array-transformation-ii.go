package main

import "math"

func zeroArrayTransformationII(nums []int, x int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	if x == 1 {
		maxVal := 0
		for _, num := range nums {
			if num > maxVal {
				maxVal = num
			}
		}
		return maxVal
	}

	// For x >= 2:
	// Let k_i be the number of type 1 operations (i==j) applied to nums[i].
	// Let p_i be the number of times nums[i] is involved in a type 2 operation (i!=j).
	// For each nums[i], we need to reduce it by nums[i]. This reduction comes from:
	// k_i * x (from type 1 ops on nums[i]) + p_i * 1 (from type 2 ops involving nums[i]) = nums[i].
	// The maximum possible value for k_i is floor(nums[i] / x).

	// Let k_total be the total number of type 1 operations performed across all elements.
	// k_total = sum(k_i).
	// Let p_total_units be the total units of reduction required from type 2 operations across all elements.
	// p_total_units = sum(p_i) = sum(nums[i] - k_i * x) = sum(nums[i]) - x * sum(k_i) = S - x * k_total,
	// where S = sum(nums).

	// The total number of operations is k_total (for type 1 ops) + p_total_ops (for type 2 ops).
	// Each type 2 operation reduces two elements by 1, contributing 2 units to p_total_units.
	// So, p_total_ops = ceil(p_total_units / 2).
	// Total operations = k_total + ceil((S - x * k_total) / 2).

	// Let f(k_total) = k_total + (S - x * k_total + 1) / 2 (using integer division for ceil).
	// This simplifies to f(k_total) = (2 * k_total + S - x * k_total + 1) / 2 = (S + k_total * (2 - x) + 1) / 2.
	// Since x >= 2, the term (2 - x) is less than or equal to 0.
	// If (2 - x) = 0 (i.e., x = 2), f(k_total) = (S + 1) / 2, which is a constant.
	// If (2 - x) < 0 (i.e., x > 2), f(k_total) decreases as k_total increases.
	// Therefore, to minimize f(k_total), we should maximize k_total.
	// The maximum possible k_total is sum(floor(nums[i] / x)).

	sumNums := 0
	maxKTotal := 0 // This will be the k_total we use
	for _, num := range nums {
		sumNums += num
		maxKTotal += num / x // Integer division in Go is floor
	}

	// Calculate the remaining sum that needs to be reduced by type 2 operations.
	// This sum is what's left after applying the maximum possible type 1 operations (maxKTotal).
	remainingSumForType2 := sumNums - maxKTotal*x

	// The number of type 2 operations needed for the remaining sum.
	// We use (val + 1) / 2 for ceil(val / 2) with integer division.
	type2Ops := (remainingSumForType2 + 1) / 2

	// The total minimum operations is the sum of max type 1 ops and required type 2 ops.
	return maxKTotal + type2Ops
}