func removeBoxes(boxes []int) int {
    n := len(boxes)
    dp := make([][][]int, n)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, n)
        }
    }
    return dfs(boxes, dp, 0, n-1, 0)
}

func dfs(boxes []int, dp [][][]int, l, r, k int) int {
    if l > r {
        return 0
    }
    if dp[l][r][k] > 0 {
        return dp[l][r][k]
    }
    for l < r && boxes[r] == boxes[r-1] {
        r--
        k++
    }
    dp[l][r][k] = dfs(boxes, dp, l, r-1, 0) + (k+1)*(k+1)
    for i := l; i < r; i++ {
        if boxes[i] == boxes[r] {
            temp := dfs(boxes, dp, l, i, k+1) + dfs(boxes, dp, i+1, r-1, 0)
            if temp > dp[l][r][k] {
                dp[l][r][k] = temp
            }
        }
    }
    return dp[l][r][k]
}