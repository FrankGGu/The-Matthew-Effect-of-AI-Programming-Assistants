func shortestCommonSupersequence(str1 string, str2 string) string {
    m, n := len(str1), len(str2)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            if str1[i-1] == str2[j-1] {
                dp[i][j] = dp[i-1][j-1] + 1
            } else {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
            }
        }
    }

    i, j := m, n
    var supersequence strings.Builder

    for i > 0 && j > 0 {
        if str1[i-1] == str2[j-1] {
            supersequence.WriteByte(str1[i-1])
            i--
            j--
        } else if dp[i-1][j] > dp[i][j-1] {
            supersequence.WriteByte(str1[i-1])
            i--
        } else {
            supersequence.WriteByte(str2[j-1])
            j--
        }
    }

    for i > 0 {
        supersequence.WriteByte(str1[i-1])
        i--
    }
    for j > 0 {
        supersequence.WriteByte(str2[j-1])
        j--
    }

    result := supersequence.String()
    runes := []rune(result)
    for left, right := 0, len(runes)-1; left < right; left, right = left+1, right-1 {
        runes[left], runes[right] = runes[right], runes[left]
    }
    return string(runes)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}