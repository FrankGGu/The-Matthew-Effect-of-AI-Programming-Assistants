package main

func findRotation(mat [][]int, target [][]int) bool {
    if len(mat) != len(target) || len(mat[0]) != len(target[0]) {
        return false
    }
    n := len(mat)
    for i := 0; i < 4; i++ {
        if compare(mat, target, n) {
            return true
        }
        rotate(mat, n)
    }
    return false
}

func compare(mat [][]int, target [][]int, n int) bool {
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if mat[i][j] != target[i][j] {
                return false
            }
        }
    }
    return true
}

func rotate(mat [][]int, n int) {
    for i := 0; i < n/2; i++ {
        for j := i; j < n-1-i; j++ {
            temp := mat[i][j]
            mat[i][j] = mat[n-1-j][i]
            mat[n-1-j][i] = mat[n-1-i][n-1-j]
            mat[n-1-i][n-1-j] = mat[j][n-1-i]
            mat[j][n-1-i] = temp
        }
    }
}