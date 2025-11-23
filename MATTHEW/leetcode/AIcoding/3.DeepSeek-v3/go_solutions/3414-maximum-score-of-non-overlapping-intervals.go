func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func maxScore(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][1] < intervals[j][1]
    })

    dp := make([]int, len(intervals))
    dp[0] = intervals[0][2]

    for i := 1; i < len(intervals); i++ {
        current := intervals[i]
        score := current[2]
        last := -1

        left, right := 0, i-1
        for left <= right {
            mid := left + (right-left)/2
            if intervals[mid][1] <= current[0] {
                last = mid
                left = mid + 1
            } else {
                right = mid - 1
            }
        }

        if last != -1 {
            score += dp[last]
        }

        dp[i] = max(dp[i-1], score)
    }

    return dp[len(intervals)-1]
}