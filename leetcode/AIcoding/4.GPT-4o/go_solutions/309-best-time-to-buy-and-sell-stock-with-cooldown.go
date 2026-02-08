func maxProfit(prices []int) int {
    n := len(prices)
    if n == 0 {
        return 0
    }

    buy := make([]int, n)
    sell := make([]int, n)

    buy[0] = -prices[0]
    sell[0] = 0

    for i := 1; i < n; i++ {
        buy[i] = max(buy[i-1], sell[i-1]-prices[i])
        sell[i] = max(sell[i-1], buy[i-1]+prices[i])
    }

    return sell[n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}