func stoneGameII(piles []int) int {
    n := len(piles)
    sum := make([]int, n+1)
    for i := n - 1; i >= 0; i-- {
        sum[i] = sum[i+1] + piles[i]
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    var solve func(int, int) int
    solve = func(i, m int) int {
        if i >= n {
            return 0
        }
        if i+2*m >= n {
            return sum[i]
        }
        if dp[i][m] > 0 {
            return dp[i][m]
        }

        ans := 0
        minVal := int(1e9)
        for x := 1; x <= 2*m; x++ {
            minVal = min(minVal, solve(i+x, max(m, x)))
        }

        ans = sum[i] - minVal
        dp[i][m] = ans
        return ans
    }

    return solve(0, 1)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}