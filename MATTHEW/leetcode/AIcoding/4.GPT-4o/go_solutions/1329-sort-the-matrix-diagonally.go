func diagonalSort(mat [][]int) [][]int {
    m, n := len(mat), len(mat[0])
    diagonals := make(map[int][]int)

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            diagonals[i-j] = append(diagonals[i-j], mat[i][j])
        }
    }

    for _, diag := range diagonals {
        sort.Ints(diag)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            mat[i][j] = diagonals[i-j][0]
            diagonals[i-j] = diagonals[i-j][1:]
        }
    }

    return mat
}