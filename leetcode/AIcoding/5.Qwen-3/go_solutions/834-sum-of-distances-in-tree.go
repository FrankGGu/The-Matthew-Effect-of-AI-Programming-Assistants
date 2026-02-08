package main

func sumDistance(intervals [][]int, k int) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })
    n := len(intervals)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    for i := 0; i < n; i++ {
        for j := 0; j <= k; j++ {
            if j == 0 {
                dp[i][j] = 0
            } else {
                dp[i][j] = math.MaxInt32
            }
        }
    }
    for i := 0; i < n; i++ {
        for j := 1; j <= k; j++ {
            if i == 0 {
                dp[i][j] = intervals[i][1] - intervals[i][0]
            } else {
                for l := 0; l < i; l++ {
                    if dp[l][j-1] != math.MaxInt32 {
                        dist := intervals[i][1] - intervals[i][0]
                        prevEnd := intervals[l][1]
                        currStart := intervals[i][0]
                        overlap := max(0, prevEnd - currStart)
                        totalDist := dp[l][j-1] + dist - overlap
                        if totalDist < dp[i][j] {
                            dp[i][j] = totalDist
                        }
                    }
                }
            }
        }
    }
    return dp[n-1][k]
}