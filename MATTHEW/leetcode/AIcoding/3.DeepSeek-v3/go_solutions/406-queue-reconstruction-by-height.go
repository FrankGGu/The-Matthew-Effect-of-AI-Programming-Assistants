func reconstructQueue(people [][]int) [][]int {
    sort.Slice(people, func(i, j int) bool {
        if people[i][0] == people[j][0] {
            return people[i][1] < people[j][1]
        }
        return people[i][0] > people[j][0]
    })

    res := make([][]int, 0)
    for _, p := range people {
        idx := p[1]
        res = append(res[:idx], append([][]int{p}, res[idx:]...)...)
    }
    return res
}