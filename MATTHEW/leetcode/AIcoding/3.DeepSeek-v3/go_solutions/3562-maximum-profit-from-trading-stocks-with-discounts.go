func maxProfit(prices []int, discounts []int, money int) int {
    n := len(prices)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, money+1)
    }

    for i := 1; i <= n; i++ {
        price := prices[i-1]
        discount := discounts[i-1]
        for j := 0; j <= money; j++ {
            dp[i][j] = dp[i-1][j]
            if j >= price {
                if dp[i-1][j-price] + discount > dp[i][j] {
                    dp[i][j] = dp[i-1][j-price] + discount
                }
            }
        }
    }

    maxDiscount := 0
    for j := 0; j <= money; j++ {
        if dp[n][j] > maxDiscount {
            maxDiscount = dp[n][j]
        }
    }

    remaining := money
    for j := money; j >= 0; j-- {
        if dp[n][j] == maxDiscount {
            remaining = j
            break
        }
    }

    return money - remaining + maxDiscount
}