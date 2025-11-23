func findRotation(mat [][]int, target [][]int) bool {
    n := len(mat)

    for k := 0; k < 4; k++ {
        if isEqual(mat, target) {
            return true
        }
        rotate(mat)
    }
    return false
}

func isEqual(mat1, mat2 [][]int) bool {
    for i := range mat1 {
        for j := range mat1[i] {
            if mat1[i][j] != mat2[i][j] {
                return false
            }
        }
    }
    return true
}

func rotate(mat [][]int) {
    n := len(mat)
    for i := 0; i < n/2; i++ {
        for j := i; j < n-i-1; j++ {
            temp := mat[i][j]
            mat[i][j] = mat[n-j-1][i]
            mat[n-j-1][i] = mat[n-i-1][n-j-1]
            mat[n-i-1][n-j-1] = mat[j][n-i-1]
            mat[j][n-i-1] = temp
        }
    }
}