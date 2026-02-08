func numWays(words []string, target string) int {
    const mod = 1_000_000_007
    m, n := len(target), len(words[0])
    count := make([][]int, 26)

    for _, word := range words {
        for j := 0; j < n; j++ {
            count[word[j]-'a'] = append(count[word[j]-'a'], j)
        }
    }

    dp := make([]int, m+1)
    dp[0] = 1

    for i := 0; i < m; i++ {
        charIndex := target[i] - 'a'
        if len(count[charIndex]) == 0 {
            return 0
        }
        newDp := make([]int, m+1)
        for j := 0; j <= i; j++ {
            newDp[j] = (newDp[j] + dp[j]) % mod
            if j < i {
                newDp[j+1] = (newDp[j+1] + int64(len(count[charIndex]))*dp[j]) % mod
            }
        }
        dp = newDp
    }

    return dp[m]
}