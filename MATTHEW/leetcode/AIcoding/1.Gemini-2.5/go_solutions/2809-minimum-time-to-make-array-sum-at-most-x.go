package main

import (
	"math"
	"sort"
)

type pair struct {
	num  int
	cost int
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minimumTime(nums []int, costs []int, x int) int {
	n := len(nums)

	// Initial check: if sum of all nums is already <= x, no operations needed.
	initialSumNums := 0
	for _, num := range nums {
		initialSumNums += num
	}
	if initialSumNums <= x {
		return 0
	}

	// Create pairs of (nums[i], costs[i])
	pairs := make([]pair, n)
	for i := 0; i < n; i++ {
		pairs[i] = pair{nums[i], costs[i]}
	}

	// Sort pairs by cost in ascending order.
	// This sorting order is crucial for the DP approach.
	// When we iterate through items sorted by cost, it helps in minimizing
	// the `C_removed` part for a given `k` (number of kept items).
	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].cost < pairs[j].cost
	})

	// dpS[j] stores the minimum sum of original 'nums' values if we keep exactly 'j' items.
	// dpC[j] stores the minimum sum of 'costs' values for these 'j' items.
	// Initialize dpS[0] = 0, dpC[0] = 0 (0 items kept, sums are 0).
	// All other dpS[j], dpC[j] are initialized to a very large value (infinity).
	dpS := make([]int, n+1)
	dpC := make([]int, n+1)
	dpS[0] = 0
	dpC[0] = 0
	for k := 1; k <= n; k++ {
		dpS[k] = math.MaxInt64
		dpC[k] = math.MaxInt64
	}

	// `minTime` stores the minimum total time found so far. Initialize to infinity.
	minTime := math.MaxInt64

	// `currentPrefixTotalCost` accumulates the sum of costs of items processed so far (pairs[0]...pairs[i]).
	currentPrefixTotalCost := 0

	// Iterate through the sorted items.
	for i := 0; i < n; i++ {
		num_i := pairs[i].num
		cost_i := pairs[i].cost

		// Update `currentPrefixTotalCost` to include `cost_i`.
		// This variable will represent `sum(costs[j] for j <= i)`.
		currentPrefixTotalCost += cost_i

		// Iterate `k` downwards to update `dpS` and `dpC` for `k+1` items.
		// `k` represents the number of items kept from `pairs[0...i-1]`.
		// The loop goes down to 0, which means `k+1` can be 1.
		for k := i; k >= 0; k-- {
			if dpS[k] != math.MaxInt64 {
				// We are considering keeping `pairs[i]`.
				// If we keep `k` items from `pairs[0...i-1]` (with sum `dpS[k]` and cost `dpC[k]`),
				// and also keep `pairs[i]`, then we have `k+1` items.
				new_S_orig_kept := dpS[k] + num_i
				new_C_kept := dpC[k] + cost_i

				// For these `k+1` kept items, the total cost of removed items (`C_removed`) is:
				// `(sum of all costs up to pairs[i]) - (sum of costs of these k+1 kept items)`.
				C_removed_val := currentPrefixTotalCost - new_C_kept

				// Calculate the total sum of kept items: `S_orig_kept + (number of kept items) * C_removed`.
				currentSumVal := new_S_orig_kept + (k+1)*C_removed_val

				// If this sum satisfies the condition, update `minTime`.
				if currentSumVal <= x {
					minTime = min(minTime, C_removed_val)
				}

				// Update DP table:
				// If `new_S_orig_kept` is strictly better, or equal `S_orig_kept` but `new_C_kept` is better, update.
				if new_S_orig_kept < dpS[k+1] || (new_S_orig_kept == dpS[k+1] && new_C_kept < dpC[k+1]) {
					dpS[k+1] = new_S_orig_kept
					dpC[k+1] = new_C_kept
				}
			}
		}
	}

	// Consider the case where 0 items are kept.
	// If 0 items are kept, `S_orig_kept = dpS[0] = 0`. `C_kept = dpC[0] = 0`.
	// The `C_removed` would be the sum of all costs of all `n` items.
	// This `totalSumAllCosts` is `currentPrefixTotalCost` after the last iteration (`i = n-1`).
	// The sum condition is `0 + 0 * totalSumAllCosts <= x`, which simplifies to `0 <= x` and is always true.
	// So, `minTime` should be updated with `totalSumAllCosts` (the cost of removing all items).
	// This is implicitly handled by the last iteration of the outer loop (`i = n-1`) where `k=0` is processed.
	// At that point, `currentPrefixTotalCost` will be the sum of all costs of all `n` items.
	// The `dpS[0]` and `dpC[0]` remain 0.
	// `C_removed_val` calculated for `k=0` (if we consider keeping 0 items) would be `currentPrefixTotalCost - dpC[0] = currentPrefixTotalCost`.
	// `currentSumVal = dpS[0] + 0 * currentPrefixTotalCost = 0`.
	// Since `0 <= x` is true, `minTime` will be updated with `currentPrefixTotalCost` (which is `totalSumAllCosts`).

	return minTime
}