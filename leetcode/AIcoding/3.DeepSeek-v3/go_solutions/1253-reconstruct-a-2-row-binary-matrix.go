func reconstructMatrix(upper int, lower int, colsum []int) [][]int {
    n := len(colsum)
    res := make([][]int, 2)
    res[0] = make([]int, n)
    res[1] = make([]int, n)

    for i := 0; i < n; i++ {
        if colsum[i] == 2 {
            res[0][i] = 1
            res[1][i] = 1
            upper--
            lower--
        } else if colsum[i] == 1 {
            if upper >= lower {
                res[0][i] = 1
                upper--
            } else {
                res[1][i] = 1
                lower--
            }
        }
    }

    if upper != 0 || lower != 0 {
        return [][]int{}
    }
    return res
}