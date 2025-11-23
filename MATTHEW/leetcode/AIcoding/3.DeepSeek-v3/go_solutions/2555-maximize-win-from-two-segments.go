func maximizeWin(prizePositions []int, k int) int {
    n := len(prizePositions)
    if n == 0 {
        return 0
    }
    dp := make([]int, n+1)
    left := 0
    res := 0
    for right := 0; right < n; right++ {
        for prizePositions[right] - prizePositions[left] > k {
            left++
        }
        current := right - left + 1
        dp[right+1] = max(dp[right], current)
        res = max(res, current + dp[left])
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}