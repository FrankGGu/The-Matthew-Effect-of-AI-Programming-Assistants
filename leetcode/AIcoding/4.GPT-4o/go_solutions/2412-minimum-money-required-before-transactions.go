func minimumMoney(transactions [][]int) int64 {
    totalLoss := int64(0)
    maxLoss := int64(0)

    for _, transaction := range transactions {
        amount, cost := int64(transaction[0]), int64(transaction[1])
        if cost > amount {
            totalLoss += cost - amount
        } else {
            maxLoss = max(maxLoss, cost-amount)
        }
    }

    return totalLoss + maxLoss
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}