import "sort"

func bestTeamScore(scores []int, ages []int) int {
	n := len(scores)
	players := make([][]int, n)
	for i := 0; i < n; i++ {
		players[i] = []int{ages[i], scores[i]}
	}

	sort.Slice(players, func(i, j int) bool {
		if players[i][0] != players[j][0] {
			return players[i][0] < players[j][0]
		}
		return players[i][1] < players[j][1]
	})

	dp := make([]int, n)
	maxScore := 0

	for i := 0; i < n; i++ {
		dp[i] = players[i][1]
		for j := 0; j < i; j++ {
			if players[i][1] >= players[j][1] {
				dp[i] = max(dp[i], dp[j]+players[i][1])
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