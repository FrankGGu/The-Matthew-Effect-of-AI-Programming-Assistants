func matrixSumQueries(n int, m int, queries [][]int) int64 {
    rowSum := make([]int, n)
    colSum := make([]int, m)
    rowCount := 0
    colCount := 0
    total := int64(0)

    for i := len(queries) - 1; i >= 0; i-- {
        query := queries[i]
        t, idx, val := query[0], query[1], query[2]

        if t == 0 {
            if rowSum[idx] == 0 {
                rowCount++
            }
            rowSum[idx] += val
        } else {
            if colSum[idx] == 0 {
                colCount++
            }
            colSum[idx] += val
        }

        if t == 0 {
            total += int64(colCount) * int64(val)
        } else {
            total += int64(rowCount) * int64(val)
        }
    }

    return total
}