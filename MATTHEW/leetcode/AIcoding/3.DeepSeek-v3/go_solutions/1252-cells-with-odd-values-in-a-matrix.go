func oddCells(m int, n int, indices [][]int) int {
    matrix := make([][]int, m)
    for i := range matrix {
        matrix[i] = make([]int, n)
    }

    for _, index := range indices {
        ri, ci := index[0], index[1]
        for j := 0; j < n; j++ {
            matrix[ri][j]++
        }
        for i := 0; i < m; i++ {
            matrix[i][ci]++
        }
    }

    count := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if matrix[i][j] % 2 != 0 {
                count++
            }
        }
    }
    return count
}