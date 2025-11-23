package main

func minFlipsMonoIncr(s string) int {
    n := len(s)
    dp0, dp1 := 0, 0
    for i := 0; i < n; i++ {
        if s[i] == '0' {
            dp0++
        } else {
            dp1++
        }
        if dp0 > dp1 {
            dp0, dp1 = dp1, dp0
        }
    }
    return min(dp0, dp1)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}