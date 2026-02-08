import "sort"

func rankTeams(votes []string) string {
	if len(votes) == 0 {
		return ""
	}
	n := len(votes[0])
	m := len(votes)
	ranks := make(map[rune][]int)
	for _, vote := range votes {
		for i, r := range vote {
			if _, ok := ranks[r]; !ok {
				ranks[r] = make([]int, n)
			}
			ranks[r][i]++
		}
	}

	teams := []rune{}
	for r := range ranks {
		teams = append(teams, r)
	}

	sort.Slice(teams, func(i, j int) bool {
		rankI := ranks[teams[i]]
		rankJ := ranks[teams[j]]
		for k := 0; k < n; k++ {
			if rankI[k] != rankJ[k] {
				return rankI[k] > rankJ[k]
			}
		}
		return teams[i] < teams[j]
	})

	result := []rune{}
	for _, team := range teams {
		result = append(result, team)
	}

	return string(result)
}