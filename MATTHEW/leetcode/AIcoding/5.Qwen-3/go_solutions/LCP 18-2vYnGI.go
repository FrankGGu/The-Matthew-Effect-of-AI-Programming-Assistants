package main

func maxStudents(seats [][]int) int {
    m, n := len(seats), len(seats[0])
    dp := make([]int, 1<<n)
    for i := 0; i < m; i++ {
        for s := 0; s < 1<<n; s++ {
            if (s & (s << 1)) != 0 {
                continue
            }
            cnt := 0
            for j := 0; j < n; j++ {
                if s & (1 << j) != 0 {
                    cnt++
                }
            }
            for prev := 0; prev < 1<<n; prev++ {
                if (prev & s) == 0 {
                    dp[s] = max(dp[s], dp[prev]+cnt)
                }
            }
        }
    }
    res := 0
    for s := 0; s < 1<<n; s++ {
        res = max(res, dp[s])
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}