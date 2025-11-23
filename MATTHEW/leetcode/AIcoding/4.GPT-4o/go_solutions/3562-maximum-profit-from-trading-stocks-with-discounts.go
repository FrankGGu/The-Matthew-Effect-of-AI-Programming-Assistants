func maxProfit(prices []int) int {
    n := len(prices)
    if n <= 1 {
        return 0
    }

    buy, sell := -prices[0], 0
    for i := 1; i < n; i++ {
        buy = max(buy, sell-prices[i])
        sell = max(sell, buy+prices[i])
    }
    return sell
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}