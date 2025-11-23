func minimumLevels(a []int) int {
    n := len(a)
    if n == 0 {
        return 0
    }
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if a[i] > a[j] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }
    maxLevel := 0
    for _, level := range dp {
        maxLevel = max(maxLevel, level)
    }
    return maxLevel
}

func max(x, y int) int {
    if x > y {
        return x
    }
    return y
}