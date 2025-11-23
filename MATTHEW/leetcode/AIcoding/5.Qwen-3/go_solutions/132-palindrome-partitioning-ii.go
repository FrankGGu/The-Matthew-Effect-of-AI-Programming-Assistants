package main

func minCut(s string) int {
    n := len(s)
    dp := make([]int, n)
    isPalindrome := make([][]bool, n)

    for i := range isPalindrome {
        isPalindrome[i] = make([]bool, n)
    }

    for i := 0; i < n; i++ {
        isPalindrome[i][i] = true
    }

    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] {
                if length == 2 {
                    isPalindrome[i][j] = true
                } else {
                    isPalindrome[i][j] = isPalindrome[i+1][j-1]
                }
            }
        }
    }

    for i := 0; i < n; i++ {
        dp[i] = i
    }

    for i := 1; i < n; i++ {
        if isPalindrome[0][i] {
            dp[i] = 0
            continue
        }
        for j := 0; j < i; j++ {
            if isPalindrome[j+1][i] {
                if dp[j]+1 < dp[i] {
                    dp[i] = dp[j] + 1
                }
            }
        }
    }

    return dp[n-1]
}