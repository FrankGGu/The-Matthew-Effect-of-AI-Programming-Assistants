func findLatestGroup(grp []int, m int) []int {
    n := len(grp)
    groups := make(map[int][]int)

    for i := 0; i < n; i++ {
        groups[grp[i]] = append(groups[grp[i]], i+1)
    }

    var result []int
    for _, indices := range groups {
        if len(indices) == m {
            if len(result) == 0 || indices[len(indices)-1] > result[len(result)-1] {
                result = indices
            }
        }
    }

    return result
}