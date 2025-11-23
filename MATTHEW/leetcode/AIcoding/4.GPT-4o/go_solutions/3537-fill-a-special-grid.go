func fillGrid(n int) [][]int {
    res := make([][]int, n)
    for i := range res {
        res[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if (i+j)%2 == 0 {
                res[i][j] = 1
            } else {
                res[i][j] = 2
            }
        }
    }

    return res
}