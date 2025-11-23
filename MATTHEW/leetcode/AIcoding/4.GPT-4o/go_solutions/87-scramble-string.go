func isScramble(s1 string, s2 string) bool {
    if len(s1) != len(s2) {
        return false
    }
    if s1 == s2 {
        return true
    }

    n := len(s1)
    count := make([]int, 26)
    for i := 0; i < n; i++ {
        count[s1[i]-'a']++
        count[s2[i]-'a']--
    }
    for _, c := range count {
        if c != 0 {
            return false
        }
    }

    dp := make([][][]bool, n)
    for i := range dp {
        dp[i] = make([][]bool, n)
        for j := range dp[i] {
            dp[i][j] = make([]bool, n+1)
        }
    }

    for length := 1; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            for j := 0; j <= n-length; j++ {
                if length == 1 {
                    dp[i][j][length] = (s1[i] == s2[j])
                } else {
                    for k := 1; k < length; k++ {
                        if (dp[i][j][k] && dp[i+k][j+k][length-k]) || (dp[i][j+length-k][k] && dp[i+k][j][length-k]) {
                            dp[i][j][length] = true
                            break
                        }
                    }
                }
            }
        }
    }

    return dp[0][0][n]
}