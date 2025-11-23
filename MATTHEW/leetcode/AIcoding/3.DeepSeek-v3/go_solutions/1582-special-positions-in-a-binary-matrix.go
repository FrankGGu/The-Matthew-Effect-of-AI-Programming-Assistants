func numSpecial(mat [][]int) int {
    rows := len(mat)
    if rows == 0 {
        return 0
    }
    cols := len(mat[0])
    rowCount := make([]int, rows)
    colCount := make([]int, cols)

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if mat[i][j] == 1 {
                rowCount[i]++
                colCount[j]++
            }
        }
    }

    count := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if mat[i][j] == 1 && rowCount[i] == 1 && colCount[j] == 1 {
                count++
            }
        }
    }

    return count
}