package main

import (
	"sort"
)

type Player struct {
	age   int
	score int
}

type ByAgeAndScore []Player

func (a ByAgeAndScore) Len() int { return len(a) }
func (a ByAgeAndScore) Swap(i, j int) { a[i], a[j] = a[j], a[i] }
func (a ByAgeAndScore) Less(i, j int) bool {
	if a[i].age != a[j].age {
		return a[i].age < a[j].age
	}
	return a[i].score < a[j].score
}

func bestTeamWithNoConflicts(scores []int, ages []int) int {
	n := len(scores)
	players := make([]Player, n)
	for i := 0; i < n; i++ {
		players[i] = Player{age: ages[i], score: scores[i]}
	}

	sort.Sort(ByAgeAndScore(players))

	dp := make([]int, n)
	maxTotalScore := 0

	for i := 0; i < n; i++ {
		dp[i] = players[i].score 
		for j := 0; j < i; j++ {
			if players[j].score <= players[i].score {
				dp[i] = max(dp[i], dp[j]+players[i].score)
			}
		}
		maxTotalScore = max(maxTotalScore, dp[i])
	}

	return maxTotalScore
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}