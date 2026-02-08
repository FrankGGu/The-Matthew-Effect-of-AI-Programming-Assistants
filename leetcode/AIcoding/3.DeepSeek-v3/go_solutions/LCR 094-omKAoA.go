func minCut(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }

    isPalindrome := make([][]bool, n)
    for i := range isPalindrome {
        isPalindrome[i] = make([]bool, n)
    }

    for i := n - 1; i >= 0; i-- {
        for j := i; j < n; j++ {
            if i == j {
                isPalindrome[i][j] = true
            } else if j == i+1 {
                isPalindrome[i][j] = s[i] == s[j]
            } else {
                isPalindrome[i][j] = s[i] == s[j] && isPalindrome[i+1][j-1]
            }
        }
    }

    dp := make([]int, n)
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