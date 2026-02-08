func numDecodings(s string) int {
    if len(s) == 0 {
        return 0
    }

    mod := 1_000_000_007
    dp := make([]int, len(s)+1)
    dp[0] = 1

    for i := 1; i <= len(s); i++ {
        if s[i-1] == '*' {
            dp[i] = dp[i-1] * 9 % mod
        } else if s[i-1] != '0' {
            dp[i] = dp[i-1]
        }

        if i > 1 {
            if s[i-2] == '*' {
                if s[i-1] == '*' {
                    dp[i] = (dp[i] + dp[i-2] * 15) % mod
                } else if s[i-1] <= '6' {
                    dp[i] = (dp[i] + dp[i-2] * 2) % mod
                } else {
                    dp[i] = (dp[i] + dp[i-2]) % mod
                }
            } else if s[i-2] == '1' {
                if s[i-1] == '*' {
                    dp[i] = (dp[i] + dp[i-2] * 9) % mod
                } else {
                    dp[i] = (dp[i] + dp[i-2]) % mod
                }
            } else if s[i-2] == '2' {
                if s[i-1] == '*' {
                    dp[i] = (dp[i] + dp[i-2] * 6) % mod
                } else if s[i-1] <= '6' {
                    dp[i] = (dp[i] + dp[i-2]) % mod
                }
            }
        }
    }

    return dp[len(s)]
}