package main

func maxStudents(seats [][]int) int {
    m, n := len(seats), len(seats[0])
    dp := make([]int, 1<<n)
    for i := 0; i < 1<<n; i++ {
        if (i & (i << 1)) == 0 {
            dp[i] = 0
            for j := 0; j < n; j++ {
                if i&(1<<j) != 0 {
                    dp[i]++
                }
            }
        }
    }
    for i := 0; i < m; i++ {
        curr := make([]int, 1<<n)
        for s := 0; s < 1<<n; s++ {
            if (s & (s << 1)) != 0 {
                continue
            }
            if seats[i][0] == 0 && (s&1) == 1 {
                continue
            }
            for prev := 0; prev < 1<<n; prev++ {
                if (prev & s) == 0 {
                    curr[s] = max(curr[s], dp[prev])
                }
            }
        }
        dp = curr
    }
    res := 0
    for _, v := range dp {
        res = max(res, v)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}