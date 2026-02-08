package main

func numSubmat(mat [][]int) int {
    m, n := len(mat), len(mat[0])
    res := 0

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if mat[i][j] == 1 {
                mat[i][j] = 1
                if i > 0 {
                    mat[i][j] += mat[i-1][j]
                }
            }
        }
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if mat[i][j] > 0 {
                minVal := mat[i][j]
                for k := j; k >= 0 && mat[i][k] > 0; k-- {
                    minVal = min(minVal, mat[i][k])
                    res += minVal
                }
            }
        }
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}