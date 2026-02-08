func minNumOfValidStrings(words []string, target string) int {
    n := len(words)
    m := len(target)
    dp := make([]int, m+1)
    dp[0] = 1

    for _, word := range words {
        wordCount := make([]int, 26)
        for _, ch := range word {
            wordCount[ch-'a']++
        }

        for j := m; j >= 0; j-- {
            if dp[j] == 0 {
                continue
            }
            for k := 1; k <= wordCount[target[j]-'a']; k++ {
                if j+k <= m {
                    dp[j+k] += dp[j]
                }
            }
        }
    }

    if dp[m] == 0 {
        return -1
    }
    return dp[m]
}