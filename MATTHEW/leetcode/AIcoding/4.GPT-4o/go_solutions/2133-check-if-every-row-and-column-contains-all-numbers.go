func checkValid(matrix [][]int) bool {
    n := len(matrix)
    rows := make([]map[int]bool, n)
    cols := make([]map[int]bool, n)

    for i := 0; i < n; i++ {
        rows[i] = make(map[int]bool)
        cols[i] = make(map[int]bool)
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            num := matrix[i][j]
            if num < 1 || num > n {
                return false
            }
            if rows[i][num] || cols[j][num] {
                return false
            }
            rows[i][num] = true
            cols[j][num] = true
        }
    }
    return true
}