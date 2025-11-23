import (
	"sort"
)

func maxTotalReward(reward []int) int {
	sort.Ints(reward)

	maxRewardVal := reward[len(reward)-1]
	maxPossibleSum := 2*maxRewardVal - 1

	dp := make([]bool, maxPossibleSum+1)
	dp[0] = true

	for _, r := range reward {
		for s := maxPossibleSum; s >= 0; s-- {
			if dp[s] && r > s {
				dp[s+r] = true
			}
		}
	}

	for s := maxPossibleSum; s >= 0; s-- {
		if dp[s] {
			return s
		}
	}

	return 0
}