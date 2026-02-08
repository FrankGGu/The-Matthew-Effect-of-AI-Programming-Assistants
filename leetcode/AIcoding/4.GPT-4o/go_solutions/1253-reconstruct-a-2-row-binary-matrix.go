func reconstructMatrix(upper int, lower int, colsum []int) [][]int {
    m := len(colsum)
    result := make([][]int, 2)
    result[0] = make([]int, m)
    result[1] = make([]int, m)

    for i := 0; i < m; i++ {
        if colsum[i] == 2 {
            if upper > 0 && lower > 0 {
                result[0][i] = 1
                result[1][i] = 1
                upper--
                lower--
            } else {
                return [][]int{}
            }
        } else if colsum[i] == 1 {
            if upper > lower {
                result[0][i] = 1
                upper--
            } else {
                result[1][i] = 1
                lower--
            }
        }
    }

    if upper == 0 && lower == 0 {
        return result
    }
    return [][]int{}
}