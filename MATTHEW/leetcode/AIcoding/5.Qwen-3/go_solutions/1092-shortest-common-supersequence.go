package main

func shortestCommonSupersequence(strs []string) string {
    if len(strs) == 0 {
        return ""
    }
    if len(strs) == 1 {
        return strs[0]
    }

    var lcs func(a, b string) string
    lcs = func(a, b string) string {
        m, n := len(a), len(b)
        dp := make([][]int, m+1)
        for i := range dp {
            dp[i] = make([]int, n+1)
        }

        for i := 1; i <= m; i++ {
            for j := 1; j <= n; j++ {
                if a[i-1] == b[j-1] {
                    dp[i][j] = dp[i-1][j-1] + 1
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                }
            }
        }

        i, j := m, n
        res := []rune{}
        for i > 0 && j > 0 {
            if a[i-1] == b[j-1] {
                res = append(res, rune(a[i-1]))
                i--
                j--
            } else if dp[i-1][j] > dp[i][j-1] {
                res = append(res, rune(a[i-1]))
                i--
            } else {
                res = append(res, rune(b[j-1]))
                j--
            }
        }

        for i > 0 {
            res = append(res, rune(a[i-1]))
            i--
        }
        for j > 0 {
            res = append(res, rune(b[j-1]))
            j--
        }

        for i, j := 0, len(res)-1; i < j; i, j = i+1, j-1 {
            res[i], res[j] = res[j], res[i]
        }

        return string(res)
    }

    result := strs[0]
    for i := 1; i < len(strs); i++ {
        result = lcs(result, strs[i])
    }

    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}