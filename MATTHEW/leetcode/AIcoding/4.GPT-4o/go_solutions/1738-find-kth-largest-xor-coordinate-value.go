func kthLargestValue(matrix [][]int, k int) int {
    m, n := len(matrix), len(matrix[0])
    xorMatrix := make([][]int, m)
    for i := 0; i < m; i++ {
        xorMatrix[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if i == 0 && j == 0 {
                xorMatrix[i][j] = matrix[i][j]
            } else if i == 0 {
                xorMatrix[i][j] = xorMatrix[i][j-1] ^ matrix[i][j]
            } else if j == 0 {
                xorMatrix[i][j] = xorMatrix[i-1][j] ^ matrix[i][j]
            } else {
                xorMatrix[i][j] = xorMatrix[i-1][j] ^ xorMatrix[i][j-1] ^ xorMatrix[i-1][j-1] ^ matrix[i][j]
            }
        }
    }

    values := make([]int, m*n)
    index := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            values[index] = xorMatrix[i][j]
            index++
        }
    }

    sort.Ints(values)
    return values[len(values)-k]
}