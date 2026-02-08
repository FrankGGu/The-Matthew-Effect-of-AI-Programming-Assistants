package main

func maxEnvelopes(envelopes [][]int) int {
    sort.Slice(envelopes, func(i, j int) bool {
        if envelopes[i][0] == envelopes[j][0] {
            return envelopes[i][1] > envelopes[j][1]
        }
        return envelopes[i][0] < envelopes[j][0]
    })

    n := len(envelopes)
    dp := make([]int, n)
    maxLen := 0

    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if envelopes[j][1] < envelopes[i][1] && dp[j]+1 > dp[i] {
                dp[i] = dp[j] + 1
            }
        }
        if dp[i] > maxLen {
            maxLen = dp[i]
        }
    }

    return maxLen
}