package main

func findSubstringInWrapup(p string) int {
    dp := make([]int, 26)
    maxLen := 0
    for i := 0; i < len(p); i++ {
        if i > 0 && (p[i]-p[i-1] == 1 || p[i-1]-p[i] == 25) {
            maxLen++
        } else {
            maxLen = 1
        }
        idx := int(p[i] - 'a')
        if maxLen > dp[idx] {
            dp[idx] = maxLen
        }
    }
    result := 0
    for _, v := range dp {
        result += v
    }
    return result
}