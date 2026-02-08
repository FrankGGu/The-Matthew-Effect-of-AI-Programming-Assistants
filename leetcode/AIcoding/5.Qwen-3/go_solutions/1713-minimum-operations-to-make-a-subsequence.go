package main

func minOperations(target []int, original []int, changed []int) int {
    m := len(target)
    n := len(original)
    if m == 0 {
        return 0
    }
    if n == 0 {
        return m
    }
    mp := make(map[int]int)
    for i := 0; i < n; i++ {
        mp[original[i]] = changed[i]
    }
    dp := make([]int, m)
    for i := 0; i < m; i++ {
        dp[i] = -1
    }
    for i := 0; i < m; i++ {
        if val, ok := mp[target[i]]; ok {
            dp[i] = val
        } else {
            dp[i] = target[i]
        }
    }
    for i := 0; i < m; i++ {
        for j := 0; j < i; j++ {
            if dp[j] < dp[i] {
                dp[i] = dp[j] + 1
            }
        }
    }
    res := 0
    for i := 0; i < m; i++ {
        if dp[i] != target[i] {
            res++
        }
    }
    return res
}