package main

func smallestSufficientTeam(favoriteComics []string, report []string) []string {
    comicToIndex := make(map[string]int)
    for i, comic := range favoriteComics {
        comicToIndex[comic] = i
    }

    n := len(favoriteComics)
    dp := make(map[int][]string)
    dp[0] = []string{}

    for _, r := range report {
        mask := 0
        for _, c := range favoriteComics {
            if c == r {
                mask |= 1 << comicToIndex[c]
            }
        }

        for key := range dp {
            newMask := key | mask
            if newMask != key {
                newTeam := append([]string{r}, dp[key]...)
                if team, ok := dp[newMask]; !ok || len(newTeam) < len(team) {
                    dp[newMask] = newTeam
                }
            }
        }
    }

    minTeam := make([]string, n)
    for _, team := range dp {
        if len(team) < len(minTeam) {
            minTeam = team
        }
    }

    return minTeam
}