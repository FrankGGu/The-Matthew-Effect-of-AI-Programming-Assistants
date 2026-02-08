func bestTeamScore(scores []int, ages []int) int {
    n := len(scores)
    players := make([][2]int, n)
    for i := 0; i < n; i++ {
        players[i] = [2]int{ages[i], scores[i]}
    }
    sort.Slice(players, func(i, j int) bool {
        if players[i][0] == players[j][0] {
            return players[i][1] < players[j][1]
        }
        return players[i][0] < players[j][0]
    })

    dp := make([]int, n)
    maxScore := 0
    for i := 0; i < n; i++ {
        dp[i] = players[i][1]
        for j := 0; j < i; j++ {
            if players[j][1] <= players[i][1] {
                if dp[j]+players[i][1] > dp[i] {
                    dp[i] = dp[j] + players[i][1]
                }
            }
        }
        if dp[i] > maxScore {
            maxScore = dp[i]
        }
    }
    return maxScore
}