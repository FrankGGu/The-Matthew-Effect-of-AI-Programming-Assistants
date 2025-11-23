func buildArray(target []int, n int) []string {
    var res []string
    current := 1
    for _, num := range target {
        for current < num {
            res = append(res, "Push")
            res = append(res, "Pop")
            current++
        }
        res = append(res, "Push")
        current++
    }
    return res
}