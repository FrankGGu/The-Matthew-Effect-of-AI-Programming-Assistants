func minOperationsMaxProfit(customers []int, boardingCost int, runningCost int) int {
	profit := -1
	maxProfit := 0
	totalCustomers := 0
	boarded := 0
	rotation := 0
	for i := 0; i < len(customers) || totalCustomers > 0; i++ {
		if i < len(customers) {
			totalCustomers += customers[i]
		}

		load := min(totalCustomers, 4)
		totalCustomers -= load
		boarded += load
		rotation++

		currentProfit := boarded * boardingCost - rotation * runningCost
		if currentProfit > maxProfit {
			maxProfit = currentProfit
			profit = rotation
		}
	}
	return profit
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}