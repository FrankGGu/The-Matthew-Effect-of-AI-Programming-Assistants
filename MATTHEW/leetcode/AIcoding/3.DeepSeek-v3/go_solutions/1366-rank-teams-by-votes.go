func rankTeams(votes []string) string {
    if len(votes) == 0 {
        return ""
    }
    teamCount := len(votes[0])
    rank := make([][]int, 26)
    for i := range rank {
        rank[i] = make([]int, teamCount)
    }

    for _, vote := range votes {
        for i, c := range vote {
            rank[c-'A'][i]++
        }
    }

    teams := make([]byte, teamCount)
    for i := range teams {
        teams[i] = votes[0][i]
    }

    sort.Slice(teams, func(i, j int) bool {
        for k := 0; k < teamCount; k++ {
            if rank[teams[i]-'A'][k] != rank[teams[j]-'A'][k] {
                return rank[teams[i]-'A'][k] > rank[teams[j]-'A'][k]
            }
        }
        return teams[i] < teams[j]
    })

    return string(teams)
}