package main

func maxStudents(seat []string) int {
    m := len(seat)
    n := len(seat[0])
    dp := make([]int, 1<<n)
    for i := 0; i < (1 << n); i++ {
        if valid(i, seat[0]) {
            dp[i] = count(i)
        }
    }
    for i := 1; i < m; i++ {
        nextDp := make([]int, 1<<n)
        for prev := 0; prev < (1 << n); prev++ {
            if dp[prev] == 0 {
                continue
            }
            for curr := 0; curr < (1 << n); curr++ {
                if valid(curr, seat[i]) && (prev & curr) == 0 {
                    nextDp[curr] = max(nextDp[curr], dp[prev]+count(curr))
                }
            }
        }
        dp = nextDp
    }
    res := 0
    for _, v := range dp {
        res = max(res, v)
    }
    return res
}

func valid(mask int, row string) bool {
    for i := 0; i < len(row); i++ {
        if (mask & (1 << i)) != 0 && row[i] == '#' {
            return false
        }
    }
    return true
}

func count(mask int) int {
    cnt := 0
    for mask > 0 {
        cnt += mask & 1
        mask >>= 1
    }
    return cnt
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}