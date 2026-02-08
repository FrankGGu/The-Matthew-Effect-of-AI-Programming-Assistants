func diagonalSort(mat [][]int) [][]int {
    m := len(mat)
    n := len(mat[0])

    diagMap := make(map[int][]int)

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            diagMap[i-j] = append(diagMap[i-j], mat[i][j])
        }
    }

    for k := range diagMap {
        sort.Ints(diagMap[k])
    }

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            mat[i][j] = diagMap[i-j][len(diagMap[i-j])-1]
            diagMap[i-j] = diagMap[i-j][:len(diagMap[i-j])-1]
        }
    }

    return mat
}