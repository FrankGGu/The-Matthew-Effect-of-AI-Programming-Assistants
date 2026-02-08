package main

func rangeAddQueries(n int, queries [][]int) [][]int {
    res := make([][]int, n)
    for i := range res {
        res[i] = make([]int, n)
    }

    for _, q := range queries {
        r1, c1, r2, c2 := q[0], q[1], q[2], q[3]
        res[r1][c1]++
        if r2+1 < n {
            res[r2+1][c1]--
        }
        if c2+1 < n {
            res[r1][c2+1]--
        }
        if r2+1 < n && c2+1 < n {
            res[r2+1][c2+1]++
        }
    }

    for i := 0; i < n; i++ {
        for j := 1; j < n; j++ {
            res[i][j] += res[i][j-1]
        }
    }

    for j := 0; j < n; j++ {
        for i := 1; i < n; i++ {
            res[i][j] += res[i-1][j]
        }
    }

    return res
}