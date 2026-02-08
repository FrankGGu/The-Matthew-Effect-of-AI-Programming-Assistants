func minSideJumps(obstacles []int) int {
    dp := [3]int{1, 0, 1}
    for i := 1; i < len(obstacles); i++ {
        next := [3]int{math.MaxInt32, math.MaxInt32, math.MaxInt32}
        for lane := 0; lane < 3; lane++ {
            if obstacles[i] == lane+1 {
                continue
            }
            for prevLane := 0; prevLane < 3; prevLane++ {
                if obstacles[i-1] == prevLane+1 {
                    continue
                }
                if lane == prevLane {
                    next[lane] = min(next[lane], dp[prevLane])
                } else {
                    next[lane] = min(next[lane], dp[prevLane]+1)
                }
            }
        }
        dp = next
    }
    return min(dp[0], min(dp[1], dp[2]))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}