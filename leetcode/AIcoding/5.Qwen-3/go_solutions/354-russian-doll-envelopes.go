package main

func maxEnvelopes(envelopes [][]int) int {
    sort.Slice(envelopes, func(i, j int) bool {
        if envelopes[i][0] == envelopes[j][0] {
            return envelopes[i][1] > envelopes[j][1]
        }
        return envelopes[i][0] < envelopes[j][0]
    })

    dp := make([]int, len(envelopes))
    for i := range dp {
        dp[i] = 1
    }

    for i := 0; i < len(envelopes); i++ {
        for j := 0; j < i; j++ {
            if envelopes[j][1] < envelopes[i][1] && dp[j]+1 > dp[i] {
                dp[i] = dp[j] + 1
            }
        }
    }

    max := 0
    for _, v := range dp {
        if v > max {
            max = v
        }
    }
    return max
}