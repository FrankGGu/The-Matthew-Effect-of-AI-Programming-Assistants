package main

func peopleWhoLoveGoodCompanies(people [][]string) []int {
    mp := make(map[string]int)
    for i, list := range people {
        for _, company := range list {
            mp[company] = i
        }
    }

    result := []int{}
    for i, list := range people {
        isSubset := true
        for _, company := range list {
            if mp[company] != i {
                isSubset = false
                break
            }
        }
        if isSubset {
            result = append(result, i)
        }
    }

    return result
}