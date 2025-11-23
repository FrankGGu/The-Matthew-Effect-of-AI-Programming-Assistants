package main

import (
	"sort"
	"strconv"
)

type ScoreWithIndex struct {
	Score int
	Index int
}

type ByScoreDescending []ScoreWithIndex

func (a ByScoreDescending) Len() int           { return len(a) }
func (a ByScoreDescending) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByScoreDescending) Less(i, j int) bool { return a[i].Score > a[j].Score }

func findRelativeRanks(score []int) []string {
	n := len(score)
	if n == 0 {
		return []string{}
	}

	scoresWithIndices := make([]ScoreWithIndex, n)
	for i := 0; i < n; i++ {
		scoresWithIndices[i] = ScoreWithIndex{Score: score[i], Index: i}
	}

	sort.Sort(ByScoreDescending(scoresWithIndices))

	result := make([]string, n)

	for i := 0; i < n; i++ {
		originalIndex := scoresWithIndices[i].Index
		rank := i + 1

		switch rank {
		case 1:
			result[originalIndex] = "Gold Medal"
		case 2:
			result[originalIndex] = "Silver Medal"
		case 3:
			result[originalIndex] = "Bronze Medal"
		default:
			result[originalIndex] = strconv.Itoa(rank)
		}
	}

	return result
}