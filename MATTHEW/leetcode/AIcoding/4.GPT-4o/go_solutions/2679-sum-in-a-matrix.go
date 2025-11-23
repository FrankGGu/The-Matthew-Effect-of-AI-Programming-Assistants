func matrixSum(mat [][]int) int {
    n := len(mat)
    m := len(mat[0])
    for i := 0; i < n; i++ {
        sort.Ints(mat[i])
    }
    sum := 0
    for j := 0; j < m; j++ {
        maxVal := 0
        for i := 0; i < n; i++ {
            if mat[i][j] > maxVal {
                maxVal = mat[i][j]
            }
        }
        sum += maxVal
    }
    return sum
}