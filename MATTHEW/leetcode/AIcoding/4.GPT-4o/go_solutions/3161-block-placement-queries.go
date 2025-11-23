func blockPlacementQueries(queries [][]int, n int) []int {
    res := make([]int, len(queries))
    blocks := make([]int, n+1)
    for i, query := range queries {
        op, x := query[0], query[1]
        if op == 1 {
            blocks[x]++
        } else {
            res[i] = blocks[x]
        }
    }
    return res
}