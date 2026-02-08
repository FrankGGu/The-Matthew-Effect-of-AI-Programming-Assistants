func minOperations(s1 string, s2 string, x int) int {
    n := len(s1)
    diffs := make([]int, 0)
    for i := 0; i < n; i++ {
        if s1[i] != s2[i] {
            diffs = append(diffs, i)
        }
    }
    m := len(diffs)
    if m % 2 != 0 {
        return -1
    }
    if m == 0 {
        return 0
    }

    dp := make([]int, m+1)
    for i := 1; i <= m; i++ {
        if i % 2 == 1 {
            dp[i] = math.MaxInt32
        } else {
            if i == 2 {
                cost := min(x, diffs[i-1] - diffs[i-2])
                dp[i] = cost
            } else {
                cost1 := dp[i-2] + min(x, diffs[i-1] - diffs[i-2])
                cost2 := dp[i-1] + x / 2
                dp[i] = min(cost1, cost2)
            }
        }
    }
    return dp[m]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}