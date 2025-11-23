package main

func maxNumOfNonOverlappingPalindromeSubstrings(s string) int {
    n := len(s)
    dp := make([][]bool, n)
    for i := range dp {
        dp[i] = make([]bool, n)
    }

    for i := 0; i < n; i++ {
        dp[i][i] = true
    }

    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] {
                if length == 2 {
                    dp[i][j] = true
                } else {
                    dp[i][j] = dp[i+1][j-1]
                }
            }
        }
    }

    result := 0
    i := 0
    for i < n {
        for j := i + 1; j <= n; j++ {
            if dp[i][j-1] {
                result++
                i = j
                break
            }
        }
        i++
    }

    return result
}