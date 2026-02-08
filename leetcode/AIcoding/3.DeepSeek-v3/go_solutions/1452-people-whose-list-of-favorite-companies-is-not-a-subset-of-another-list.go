func peopleIndexes(favoriteCompanies [][]string) []int {
    n := len(favoriteCompanies)
    res := make([]int, 0)
    for i := 0; i < n; i++ {
        isSubset := false
        setI := make(map[string]bool)
        for _, c := range favoriteCompanies[i] {
            setI[c] = true
        }
        for j := 0; j < n; j++ {
            if i == j {
                continue
            }
            setJ := make(map[string]bool)
            for _, c := range favoriteCompanies[j] {
                setJ[c] = true
            }
            subset := true
            for c := range setI {
                if !setJ[c] {
                    subset = false
                    break
                }
            }
            if subset {
                isSubset = true
                break
            }
        }
        if !isSubset {
            res = append(res, i)
        }
    }
    return res
}