func minOperationsMaxProfit(customers []int, boardingCost int, runningCost int) int {
    maxProfit := 0
    currentProfit := 0
    remainingCustomers := 0
    minRotations := -1
    rotations := 0

    for i := 0; i < len(customers) || remainingCustomers > 0; i++ {
        if i < len(customers) {
            remainingCustomers += customers[i]
        }

        boarding := min(4, remainingCustomers)
        remainingCustomers -= boarding
        currentProfit += boarding * boardingCost - runningCost
        rotations++

        if currentProfit > maxProfit {
            maxProfit = currentProfit
            minRotations = rotations
        }
    }

    return minRotations
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}