func numSpecial(mat [][]int) int {
    rows := len(mat)
    cols := len(mat[0])
    rowSum := make([]int, rows)
    colSum := make([]int, cols)

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if mat[i][j] == 1 {
                rowSum[i]++
                colSum[j]++
            }
        }
    }

    count := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if mat[i][j] == 1 && rowSum[i] == 1 && colSum[j] == 1 {
                count++
            }
        }
    }

    return count
}