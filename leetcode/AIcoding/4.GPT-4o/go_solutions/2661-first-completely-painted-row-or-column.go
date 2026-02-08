func firstCompleteIndex(rows []int, cols []int) int {
    n := len(rows)
    rowCount := make([]int, n)
    colCount := make([]int, n)
    rowPainted := make([]bool, n)
    colPainted := make([]bool, n)

    for i := 0; i < len(rows); i++ {
        rowCount[rows[i]-1]++
        if rowCount[rows[i]-1] == n {
            return i
        }

        colCount[cols[i]-1]++
        if colCount[cols[i]-1] == n {
            return i
        }
    }

    return -1
}