package main

import (
	"sort"
	"strings"
)

func rankTeams(votes []string) string {
	if len(votes) == 0 {
		return ""
	}

	numTeams := len(votes[0])
	teamCounts := make(map[rune][]int)

	// Initialize teamCounts for all teams and collect unique teams
	teams := make([]rune, 0, numTeams)
	for _, r := range votes[0] {
		teamCounts[r] = make([]int, numTeams)
		teams = append(teams, r)
	}

	// Populate teamCounts based on votes
	for _, vote := range votes {
		for i, team := range vote {
			teamCounts[team][i]++
		}
	}

	// Sort the teams slice using a custom comparator
	sort.Slice(teams, func(i, j int) bool {
		teamA := teams[i]
		teamB := teams[j]

		// Compare vote counts at each rank position
		for k := 0; k < numTeams; k++ {
			if teamCounts[teamA][k] != teamCounts[teamB][k] {
				return teamCounts[teamA][k] > teamCounts[teamB][k] // Higher votes at a better rank comes first
			}
		}
		// If all vote counts are equal, sort alphabetically
		return teamA < teamB
	})

	// Build the result string from the sorted teams
	var result strings.Builder
	for _, team := range teams {
		result.WriteRune(team)
	}

	return result.String()
}