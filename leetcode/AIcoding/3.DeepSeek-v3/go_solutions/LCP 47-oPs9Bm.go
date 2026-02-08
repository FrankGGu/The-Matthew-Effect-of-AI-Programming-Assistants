func securityCheck(people [][]int) []int {
    sort.Slice(people, func(i, j int) bool {
        if people[i][1] == people[j][1] {
            return people[i][0] < people[j][0]
        }
        return people[i][1] < people[j][1]
    })
    res := make([]int, len(people))
    for i, p := range people {
        res[i] = p[0]
    }
    return res
}