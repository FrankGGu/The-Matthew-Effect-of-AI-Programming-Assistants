func getWordsInLongestSubsequence(n int, words []string, groups []int) []string {
    dp := make([]int, n)
    prev := make([]int, n)
    for i := range dp {
        dp[i] = 1
        prev[i] = -1
    }

    maxLen := 1
    lastIdx := 0

    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            if groups[i] != groups[j] && len(words[i]) == len(words[j]) && hammingDistance(words[i], words[j]) == 1 {
                if dp[j]+1 > dp[i] {
                    dp[i] = dp[j] + 1
                    prev[i] = j
                }
            }
        }
        if dp[i] > maxLen {
            maxLen = dp[i]
            lastIdx = i
        }
    }

    res := make([]string, maxLen)
    idx := lastIdx
    for i := maxLen - 1; i >= 0; i-- {
        res[i] = words[idx]
        idx = prev[idx]
    }

    return res
}

func hammingDistance(a, b string) int {
    distance := 0
    for i := 0; i < len(a); i++ {
        if a[i] != b[i] {
            distance++
        }
    }
    return distance
}