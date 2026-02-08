func peopleWhoseList(favoriteCompanies [][]string) []int {
    n := len(favoriteCompanies)
    res := []int{}
    for i := 0; i < n; i++ {
        isSubset := false
        for j := 0; j < n; j++ {
            if i == j {
                continue
            }
            if isSubsetOf(favoriteCompanies[i], favoriteCompanies[j]) {
                isSubset = true
                break
            }
        }
        if !isSubset {
            res = append(res, i)
        }
    }
    sort.Ints(res)
    return res
}

func isSubsetOf(list1 []string, list2 []string) bool {
    set2 := make(map[string]bool)
    for _, company := range list2 {
        set2[company] = true
    }
    for _, company := range list1 {
        if !set2[company] {
            return false
        }
    }
    return true
}

import "sort"