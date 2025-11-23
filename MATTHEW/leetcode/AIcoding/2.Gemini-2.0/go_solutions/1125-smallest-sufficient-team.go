func smallestSufficientTeam(req_skills []string, people [][]string) []int {
	n := len(req_skills)
	m := len(people)
	skill_id := make(map[string]int)
	for i, skill := range req_skills {
		skill_id[skill] = i
	}

	dp := make([]int, 1<<n)
	for i := range dp {
		dp[i] = -1
	}
	dp[0] = 0

	ans := []int{}

	for i := 0; i < m; i++ {
		person_mask := 0
		for _, skill := range people[i] {
			if _, ok := skill_id[skill]; ok {
				person_mask |= 1 << skill_id[skill]
			}
		}

		for mask := 0; mask < (1 << n); mask++ {
			if dp[mask] == -1 {
				continue
			}

			new_mask := mask | person_mask
			if dp[new_mask] == -1 || dp[new_mask] > dp[mask]+1 {
				dp[new_mask] = dp[mask] + 1
			}
		}
	}

	covered_skills := make([]int, 1<<n)
	for i := 0; i < m; i++ {
		person_mask := 0
		for _, skill := range people[i] {
			if _, ok := skill_id[skill]; ok {
				person_mask |= 1 << skill_id[skill]
			}
		}
		covered_skills[person_mask] = i
	}

	mask := (1 << n) - 1
	for mask > 0 {
		for i := 0; i < m; i++ {
			person_mask := 0
			for _, skill := range people[i] {
				if _, ok := skill_id[skill]; ok {
					person_mask |= 1 << skill_id[skill]
				}
			}
			if mask&person_mask == 0 {
				continue
			}
			prev_mask := mask & (^person_mask)
			if dp[prev_mask] != -1 && dp[prev_mask]+1 == dp[mask] {
				ans = append(ans, i)
				mask = prev_mask
				break
			}
		}
	}

	return ans
}