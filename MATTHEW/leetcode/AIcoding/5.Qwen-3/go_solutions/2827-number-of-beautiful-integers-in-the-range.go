package main

func numberOfBeautifulIntegers(kmp string) int {
    n := len(kmp)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    dp[0][0] = 1
    for i := 0; i < n; i++ {
        for j := 0; j <= i; j++ {
            if dp[i][j] == 0 {
                continue
            }
            for k := 0; k <= 9; k++ {
                cnt := j
                if k < int(kmp[i]-'0') {
                    dp[i+1][cnt] += dp[i][j]
                } else if k == int(kmp[i]-'0') {
                    dp[i+1][cnt] += dp[i][j]
                } else {
                    break
                }
            }
        }
    }
    return dp[n][0]
}