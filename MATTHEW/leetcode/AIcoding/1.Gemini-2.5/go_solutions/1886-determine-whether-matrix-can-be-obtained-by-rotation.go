func findRotation(mat [][]int, target [][]int) bool {
    n := len(mat)

    equals := func(m1 [][]int, m2 [][]int) bool {
        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                if m1[i][j] != m2[i][j] {
                    return false
                }
            }
        }
        return true
    }

    if equals(mat, target) {
        return true
    }

    for k := 0; k < 3; k++ {
        rotatedMat := make([][]int, n)
        for i := range rotatedMat {
            rotatedMat[i] = make([]int, n)
        }

        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                rotatedMat[j][n-1-i] = mat[i][j]
            }
        }
        mat = rotatedMat

        if equals(mat, target) {
            return true
        }
    }

    return false
}