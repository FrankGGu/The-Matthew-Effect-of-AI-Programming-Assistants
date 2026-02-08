func tallestBillboard(rods []int) int {
    dp := make([]int, 10001)
    dp[0] = 0

    for _, rod := range rods {
        for j := 10000 - rod; j >= 0; j-- {
            if dp[j] >= 0 {
                dp[j+rod] = max(dp[j+rod], dp[j])
                dp[j] = max(dp[j], dp[j]-rod)
            }
        }
    }

    return dp[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}