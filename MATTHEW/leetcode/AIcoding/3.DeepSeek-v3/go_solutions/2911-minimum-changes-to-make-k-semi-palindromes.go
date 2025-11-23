func minimumChanges(s string, k int) int {
    n := len(s)
    cost := make([][]int, n)
    for i := range cost {
        cost[i] = make([]int, n)
    }

    for l := 1; l < n; l++ {
        for i := 0; i+l < n; i++ {
            j := i + l
            cost[i][j] = computeCost(s, i, j)
        }
    }

    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = math.MaxInt32
        }
    }
    dp[0][0] = 0

    for i := 1; i <= n; i++ {
        for j := 1; j <= k; j++ {
            for m := 0; m < i; m++ {
                if dp[m][j-1] != math.MaxInt32 {
                    dp[i][j] = min(dp[i][j], dp[m][j-1]+cost[m][i-1])
                }
            }
        }
    }

    return dp[n][k]
}

func computeCost(s string, l, r int) int {
    minCost := math.MaxInt32
    length := r - l + 1
    for d := 1; d < length; d++ {
        if length%d == 0 {
            cost := 0
            for i := 0; i < d; i++ {
                left, right := l+i, r-(d-1-i)
                for left < right {
                    if s[left] != s[right] {
                        cost++
                    }
                    left += d
                    right -= d
                }
            }
            minCost = min(minCost, cost)
        }
    }
    return minCost
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}