func lenLongestFibSubseq(arr []int) int {
    n := len(arr)
    index := make(map[int]int)
    for i, num := range arr {
        index[num] = i
    }
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    ans := 0
    for k := 0; k < n; k++ {
        for j := 0; j < k; j++ {
            i := index[arr[k]-arr[j]]
            if arr[k]-arr[j] < arr[j] && i >= 0 {
                dp[j][k] = dp[i][j] + 1
            } else {
                dp[j][k] = 2
            }
            ans = max(ans, dp[j][k])
        }
    }
    if ans <= 2 {
        return 0
    }
    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}