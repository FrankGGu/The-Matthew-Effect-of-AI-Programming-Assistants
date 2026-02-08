package main

func matrixBlockSum(mat [][]int, k int) [][]int {
    m := len(mat)
    n := len(mat[0])
    res := make([][]int, m)
    for i := range res {
        res[i] = make([]int, n)
    }
    prefix := make([][]int, m+1)
    for i := range prefix {
        prefix[i] = make([]int, n+1)
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            prefix[i+1][j+1] = mat[i][j] + prefix[i][j+1] + prefix[i+1][j] - prefix[i][j]
        }
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            x1 := i - k
            y1 := j - k
            x2 := i + k
            y2 := j + k
            if x1 < 0 {
                x1 = 0
            }
            if y1 < 0 {
                y1 = 0
            }
            if x2 >= m {
                x2 = m - 1
            }
            if y2 >= n {
                y2 = n - 1
            }
            res[i][j] = prefix[x2+1][y2+1] - prefix[x1][y2+1] - prefix[x2+1][y1] + prefix[x1][y1]
        }
    }
    return res
}