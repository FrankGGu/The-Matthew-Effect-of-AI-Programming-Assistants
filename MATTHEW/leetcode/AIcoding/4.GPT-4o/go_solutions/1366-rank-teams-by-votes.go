package main

import (
	"sort"
)

func rankTeams(votes []string) string {
	teamCount := make(map[rune][]int)
	teamSet := make(map[rune]struct{})

	for _, vote := range votes {
		for i, c := range vote {
			teamSet[c] = struct{}{}
			teamCount[c] = append(teamCount[c], i)
		}
	}

	type team struct {
		name  rune
		count []int
	}

	var teams []team
	for k := range teamSet {
		teams = append(teams, team{name: k, count: teamCount[k]})
	}

	sort.Slice(teams, func(i, j int) bool {
		for k := 0; k < len(teams[i].count); k++ {
			if teams[i].count[k] != teams[j].count[k] {
				return teams[i].count[k] < teams[j].count[k]
			}
		}
		return teams[i].name < teams[j].name
	})

	result := ""
	for _, t := range teams {
		result += string(t.name)
	}
	return result
}