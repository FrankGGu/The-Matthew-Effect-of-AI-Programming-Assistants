func differenceOfDistinctValues(mat [][]int) [][]int {
    m, n := len(mat), len(mat[0])
    result := make([][]int, m)
    for i := range result {
        result[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            left := make(map[int]struct{})
            right := make(map[int]struct{})

            for k := 1; i-k >= 0 && j-k >= 0; k++ {
                left[mat[i-k][j-k]] = struct{}{}
            }

            for k := 1; i+k < m && j+k < n; k++ {
                right[mat[i+k][j+k]] = struct{}{}
            }

            result[i][j] = len(left) - len(right)
        }
    }

    return result
}