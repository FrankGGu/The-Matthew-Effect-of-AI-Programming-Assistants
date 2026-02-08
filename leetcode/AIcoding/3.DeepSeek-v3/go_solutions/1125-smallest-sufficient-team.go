func smallestSufficientTeam(req_skills []string, people [][]string) []int {
    skillToID := make(map[string]int)
    for i, skill := range req_skills {
        skillToID[skill] = i
    }

    n := len(req_skills)
    target := (1 << n) - 1

    peopleMask := make([]int, len(people))
    for i, skills := range people {
        mask := 0
        for _, skill := range skills {
            mask |= 1 << skillToID[skill]
        }
        peopleMask[i] = mask
    }

    dp := make([]int, 1 << n)
    parent := make([]int, 1 << n)
    team := make([]int, 1 << n)
    for i := range dp {
        dp[i] = -1
    }
    dp[0] = 0

    for mask := 0; mask < (1 << n); mask++ {
        if dp[mask] == -1 {
            continue
        }
        for i := 0; i < len(people); i++ {
            nextMask := mask | peopleMask[i]
            if dp[nextMask] == -1 || dp[nextMask] > dp[mask] + 1 {
                dp[nextMask] = dp[mask] + 1
                parent[nextMask] = mask
                team[nextMask] = i
            }
        }
    }

    res := []int{}
    current := target
    for current != 0 {
        res = append(res, team[current])
        current = parent[current]
    }

    return res
}