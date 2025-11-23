func findRotation(mat [][]int, target [][]int) bool {
    n := len(mat)
    rotate90, rotate180, rotate270 := true, true, true
    original := true

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if mat[i][j] != target[i][j] {
                original = false
            }
            if mat[i][j] != target[j][n-1-i] {
                rotate90 = false
            }
            if mat[i][j] != target[n-1-i][n-1-j] {
                rotate180 = false
            }
            if mat[i][j] != target[n-1-j][i] {
                rotate270 = false
            }
            if !original && !rotate90 && !rotate180 && !rotate270 {
                return false
            }
        }
    }
    return original || rotate90 || rotate180 || rotate270
}