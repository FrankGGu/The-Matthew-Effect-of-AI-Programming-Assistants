package main

func bestTeamWinning(nums []int, freq []int) int {
    type Player struct {
        score int
        age   int
    }
    players := make([]Player, len(nums))
    for i := 0; i < len(nums); i++ {
        players[i] = Player{nums[i], freq[i]}
    }
    sort.Slice(players, func(i, j int) bool {
        return players[i].age < players[j].age
    })
    dp := make([]int, len(players))
    maxScore := 0
    for i := 0; i < len(players); i++ {
        dp[i] = players[i].score
        for j := 0; j < i; j++ {
            if players[j].score <= players[i].score {
                dp[i] = max(dp[i], dp[j]+players[i].score)
            }
        }
        maxScore = max(maxScore, dp[i])
    }
    return maxScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}