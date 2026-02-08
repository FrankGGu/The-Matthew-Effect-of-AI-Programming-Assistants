func peopleIndexes(favoriteCompanies [][]string) []int {
    n := len(favoriteCompanies)
    result := []int{}

    favoriteSet := make([]map[string]struct{}, n)
    for i := 0; i < n; i++ {
        favoriteSet[i] = make(map[string]struct{})
        for _, company := range favoriteCompanies[i] {
            favoriteSet[i][company] = struct{}{}
        }
    }

    for i := 0; i < n; i++ {
        isSubset := false
        for j := 0; j < n; j++ {
            if i != j {
                subset := true
                for company := range favoriteSet[i] {
                    if _, exists := favoriteSet[j][company]; !exists {
                        subset = false
                        break
                    }
                }
                if subset {
                    isSubset = true
                    break
                }
            }
        }
        if !isSubset {
            result = append(result, i)
        }
    }

    return result
}