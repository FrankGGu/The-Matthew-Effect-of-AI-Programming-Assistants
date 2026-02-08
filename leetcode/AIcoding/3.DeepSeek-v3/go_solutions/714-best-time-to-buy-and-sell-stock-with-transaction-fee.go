func maxProfit(prices []int, fee int) int {
    n := len(prices)
    if n == 0 {
        return 0
    }
    cash, hold := 0, -prices[0]
    for i := 1; i < n; i++ {
        cash = max(cash, hold + prices[i] - fee)
        hold = max(hold, cash - prices[i])
    }
    return cash
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}