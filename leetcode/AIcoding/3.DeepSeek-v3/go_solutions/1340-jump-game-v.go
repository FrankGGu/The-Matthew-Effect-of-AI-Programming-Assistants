func maxJumps(arr []int, d int) int {
    n := len(arr)
    dp := make([]int, n)
    res := 0

    var dfs func(int) int
    dfs = func(i int) int {
        if dp[i] != 0 {
            return dp[i]
        }
        maxVal := 1
        for j := i + 1; j <= min(i+d, n-1) && arr[j] < arr[i]; j++ {
            maxVal = max(maxVal, dfs(j)+1)
        }
        for j := i - 1; j >= max(i-d, 0) && arr[j] < arr[i]; j-- {
            maxVal = max(maxVal, dfs(j)+1)
        }
        dp[i] = maxVal
        return maxVal
    }

    for i := 0; i < n; i++ {
        res = max(res, dfs(i))
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}