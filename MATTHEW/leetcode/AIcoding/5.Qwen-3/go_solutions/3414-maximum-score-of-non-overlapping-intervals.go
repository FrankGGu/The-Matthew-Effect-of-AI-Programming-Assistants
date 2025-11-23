package main

func maximumScore(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][1] < intervals[j][1]
    })

    n := len(intervals)
    dp := make([]int, n)

    for i := 0; i < n; i++ {
        dp[i] = intervals[i][2]
        for j := 0; j < i; j++ {
            if intervals[j][1] <= intervals[i][0] {
                dp[i] = max(dp[i], dp[j]+intervals[i][2])
            }
        }
    }

    maxScore := 0
    for _, score := range dp {
        if score > maxScore {
            maxScore = score
        }
    }

    return maxScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}