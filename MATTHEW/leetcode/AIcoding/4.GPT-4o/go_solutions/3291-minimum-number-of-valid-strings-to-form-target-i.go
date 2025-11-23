func minNumberOfValidStrings(target string, words []string) int {
    count := make([]int, 26)
    for _, c := range target {
        count[c-'a']++
    }

    dp := make([]int, len(target)+1)
    for i := range dp {
        dp[i] = len(words) + 1
    }
    dp[0] = 0

    for _, word := range words {
        wordCount := make([]int, 26)
        for _, c := range word {
            wordCount[c-'a']++
        }

        for j := len(target); j >= 0; j-- {
            if dp[j] < len(words)+1 {
                nextJ := j
                for k := 0; k < 26; k++ {
                    if wordCount[k] > 0 {
                        nextJ = min(nextJ, j+min(count[k], wordCount[k]))
                    }
                }
                dp[nextJ] = min(dp[nextJ], dp[j]+1)
            }
        }
    }

    if dp[len(target)] == len(words)+1 {
        return -1
    }
    return dp[len(target)]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}