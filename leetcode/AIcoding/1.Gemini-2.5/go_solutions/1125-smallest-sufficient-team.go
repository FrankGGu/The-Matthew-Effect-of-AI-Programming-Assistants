func smallestSufficientTeam(req_skills []string, people [][]string) []int {
	n := len(req_skills)
	m := len(people)

	skillMap := make(map[string]int)
	for i, skill := range req_skills {
		skillMap[skill] = i
	}

	peopleSkills := make([]int, m)
	for i, personSkills := range people {
		mask := 0
		for _, skill := range personSkills {
			if skillIdx, ok := skillMap[skill]; ok {
				mask |= (1 << skillIdx)
			}
		}
		peopleSkills[i] = mask
	}

	targetMask := (1 << n) - 1

	dp := make([]int, 1<<n)
	for i := 1; i < (1 << n); i++ {
		dp[i] = m + 1
	}
	dp[0] = 0

	parent := make([]int, 1<<n)
	personUsed := make([]int, 1<<n)

	for pIdx := 0; pIdx < m; pIdx++ {
		pSkills := peopleSkills[pIdx]
		for mask := 0; mask < (1 << n); mask++ {
			if dp[mask] == m+1 {
				continue
			}

			newMask := mask | pSkills
			if dp[mask]+1 < dp[newMask] {
				dp[newMask] = dp[mask] + 1
				parent[newMask] = mask
				personUsed[newMask] = pIdx
			}
		}
	}

	result := []int{}
	currentMask := targetMask
	for currentMask > 0 {
		pIdx := personUsed[currentMask]
		result = append(result, pIdx)
		currentMask = parent[currentMask]
	}

	return result
}