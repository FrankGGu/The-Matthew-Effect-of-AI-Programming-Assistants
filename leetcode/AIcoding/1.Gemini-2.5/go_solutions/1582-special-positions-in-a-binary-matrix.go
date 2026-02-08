func numSpecial(mat [][]int) int {
    rows := len(mat)
    cols := len(mat[0])

    rowSums := make([]int, rows)
    colSums := make([]int, cols)

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if mat[i][j] == 1 {
                rowSums[i]++
                colSums[j]++
            }
        }
    }

    specialPositions := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if mat[i][j] == 1 && rowSums[i] == 1 && colSums[j] == 1 {
                specialPositions++
            }
        }
    }

    return specialPositions
}