func minimumMoney(transactions [][]int) int64 {
    var totalLose int64 = 0
    var maxCashback int64 = 0
    var maxCost int64 = 0

    for _, t := range transactions {
        cost := int64(t[0])
        cashback := int64(t[1])
        if cost > cashback {
            totalLose += cost - cashback
            if cashback > maxCashback {
                maxCashback = cashback
            }
        } else {
            if cost > maxCost {
                maxCost = cost
            }
        }
    }

    if totalLose == 0 {
        return maxCost
    }
    return totalLose + max(maxCashback, maxCost)
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}