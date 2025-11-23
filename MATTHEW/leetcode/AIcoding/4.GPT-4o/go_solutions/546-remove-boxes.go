func removeBoxes(boxes []int) int {
    n := len(boxes)
    dp := make([][][]int, n)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, n)
        }
    }

    var dfs func(l, r, k int) int
    dfs = func(l, r, k int) int {
        if l > r {
            return 0
        }
        for r > l && boxes[r] == boxes[r-1] {
            r--
            k++
        }
        if dp[l][r][k] > 0 {
            return dp[l][r][k]
        }
        dp[l][r][k] = dfs(l, r-1, 0) + (k+1)*(k+1)
        for m := l; m < r; m++ {
            if boxes[m] == boxes[r] {
                dp[l][r][k] = max(dp[l][r][k], dfs(l, m, k+1)+dfs(m+1, r-1, 0))
            }
        }
        return dp[l][r][k]
    }

    return dfs(0, n-1, 0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}