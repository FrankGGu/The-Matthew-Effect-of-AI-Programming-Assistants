package main

func longestIdealString(s string, k int) int {
    dp := make([]int, 26)
    for _, c := range s {
        idx := int(c - 'a')
        maxLen := 0
        for i := 0; i < 26; i++ {
            if abs(i-idx) <= k {
                if dp[i] > maxLen {
                    maxLen = dp[i]
                }
            }
        }
        dp[idx] = maxLen + 1
    }
    max := 0
    for _, v := range dp {
        if v > max {
            max = v
        }
    }
    return max
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}