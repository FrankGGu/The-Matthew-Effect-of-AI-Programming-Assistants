func peopleWhoseListOfFavoriteCompaniesIsNotASubsetOfAnotherList(favoriteCompanies [][]string) []int {
	n := len(favoriteCompanies)
	result := []int{}

	companySets := make([]map[string]bool, n)
	for i := 0; i < n; i++ {
		companySets[i] = make(map[string]bool)
		for _, company := range favoriteCompanies[i] {
			companySets[i][company] = true
		}
	}

	for i := 0; i < n; i++ {
		isSubsetOfAnyOther := false
		for j := 0; j < n; j++ {
			if i == j {
				continue
			}

			if len(favoriteCompanies[i]) > len(favoriteCompanies[j]) {
				continue
			}

			currentSetI := companySets[i]
			targetSetJ := companySets[j]

			isCurrentISubsetOfJ := true
			for company := range currentSetI {
				if !targetSetJ[company] {
					isCurrentISubsetOfJ = false
					break
				}
			}

			if isCurrentISubsetOfJ {
				isSubsetOfAnyOther = true
				break
			}
		}
		if !isSubsetOfAnyOther {
			result = append(result, i)
		}
	}
	return result
}