package main

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func maxNumberOfAlloys(n int, k int, budget int, composition [][]int, stock []int, cost []int) int64 {
	maxAlloys := int64(0)

	for j := 0; j < k; j++ { // Iterate through each alloy type
		low := int64(0)
		high := int64(2_000_000_000 + 7) // A sufficiently large upper bound for the number of alloys

		currentMax := int64(0)
		for low <= high {
			mid := low + (high-low)/2

			if mid == 0 { // Can always make 0 alloys
				currentMax = max(currentMax, mid)
				low = mid + 1
				continue
			}

			if check(mid, j, composition, stock, cost, budget, n) {
				currentMax = max(currentMax, mid)
				low = mid + 1
			} else {
				high = mid - 1
			}
		}
		maxAlloys = max(maxAlloys, currentMax)
	}

	return maxAlloys
}

func check(targetAlloys int64, alloyType int, composition [][]int, stock []int, cost []int, budget int, n int) bool {
	totalCostNeeded := int64(0)
	budget64 := int64(budget)

	for i := 0; i < n; i++ {
		requiredForOne := int64(composition[alloyType][i])
		if requiredForOne == 0 {
			continue
		}

		// Calculate the maximum amount of metal 'i' we can acquire (from stock + buying).
		// This is stock[i] + budget/cost[i].
		// This value can be up to 10^9 (stock) + 10^9/1 (budget/cost) = 2 * 10^9.
		// It fits in int64.
		maxAcquirableForThisMetal := int64(stock[i]) + budget64/int64(cost[i])

		// If targetAlloys * requiredForOne would exceed maxAcquirableForThisMetal,
		// it's impossible to make this many alloys, and neededMetal might overflow int64
		// if we directly multiply without this check.
		// We use division to prevent overflow during the check.
		// If requiredForOne > 0, we can safely divide.
		if targetAlloys > maxAcquirableForThisMetal / requiredForOne {
			return false
		}

		neededMetal := targetAlloys * requiredForOne

		if neededMetal <= int64(stock[i]) {
			continue
		}
		toBuy := neededMetal - int64(stock[i])

		// Check if buying 'toBuy' units of metal 'i' would exceed the budget for this metal.
		// toBuy * cost[i] must be <= budget64.
		// If toBuy > budget64 / cost[i], it implies toBuy * cost[i] > budget64.
		// This check also prevents overflow for costForThisMetal, as totalCostNeeded is capped by budget64.
		if toBuy > budget64/int64(cost[i]) {
			return false
		}
		costForThisMetal := toBuy * int64(cost[i])

		totalCostNeeded += costForThisMetal
		if totalCostNeeded > budget64 {
			return false
		}
	}
	return true
}