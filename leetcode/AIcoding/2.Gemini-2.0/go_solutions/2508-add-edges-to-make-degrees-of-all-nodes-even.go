func isPossible(n int, edges [][]int) bool {
	degree := make([]int, n+1)
	odd := []int{}
	for _, edge := range edges {
		degree[edge[0]]++
		degree[edge[1]]++
	}
	for i := 1; i <= n; i++ {
		if degree[i]%2 != 0 {
			odd = append(odd, i)
		}
	}

	if len(odd) == 0 {
		return true
	}
	if len(odd) > 4 {
		return false
	}

	if len(odd) == 2 {
		a, b := odd[0], odd[1]
		found := false
		for _, edge := range edges {
			if (edge[0] == a && edge[1] == b) || (edge[0] == b && edge[1] == a) {
				found = true
				break
			}
		}
		if !found {
			return true
		}
		for i := 1; i <= n; i++ {
			if i != a && i != b {
				found := false
				for _, edge := range edges {
					if (edge[0] == a && edge[1] == i) || (edge[0] == i && edge[1] == a) {
						found = true
						break
					}
				}
				if !found {
					found2 := false
					for _, edge := range edges {
						if (edge[0] == b && edge[1] == i) || (edge[0] == i && edge[1] == b) {
							found2 = true
							break
						}
					}
					if !found2 {
						return true
					}

				}
			}
		}

		return false

	}

	if len(odd) == 4 {
		a, b, c, d := odd[0], odd[1], odd[2], odd[3]
		foundAB := false
		for _, edge := range edges {
			if (edge[0] == a && edge[1] == b) || (edge[0] == b && edge[1] == a) {
				foundAB = true
				break
			}
		}

		foundCD := false
		for _, edge := range edges {
			if (edge[0] == c && edge[1] == d) || (edge[0] == d && edge[1] == c) {
				foundCD = true
				break
			}
		}

		if !foundAB && !foundCD {
			return true
		}

		foundAC := false
		for _, edge := range edges {
			if (edge[0] == a && edge[1] == c) || (edge[0] == c && edge[1] == a) {
				foundAC = true
				break
			}
		}
		foundBD := false
		for _, edge := range edges {
			if (edge[0] == b && edge[1] == d) || (edge[0] == d && edge[1] == b) {
				foundBD = true
				break
			}
		}

		if !foundAC && !foundBD {
			return true
		}

		foundAD := false
		for _, edge := range edges {
			if (edge[0] == a && edge[1] == d) || (edge[0] == d && edge[1] == a) {
				foundAD = true
				break
			}
		}

		foundBC := false
		for _, edge := range edges {
			if (edge[0] == b && edge[1] == c) || (edge[0] == c && edge[1] == b) {
				foundBC = true
				break
			}
		}

		if !foundAD && !foundBC {
			return true
		}

		return false
	}

	return false
}