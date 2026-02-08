func kthSmallestPath(destination []int, k int) string {
    v, h := destination[0], destination[1]
    n := v + h
    comb := make([][]int, n+1)
    for i := range comb {
        comb[i] = make([]int, n+1)
        comb[i][0] = 1
        for j := 1; j <= i; j++ {
            comb[i][j] = comb[i-1][j-1] + comb[i-1][j]
        }
    }

    res := make([]byte, n)
    for i := 0; i < n; i++ {
        if h > 0 {
            c := comb[v+h-1][h-1]
            if k > c {
                res[i] = 'V'
                k -= c
                v--
            } else {
                res[i] = 'H'
                h--
            }
        } else {
            res[i] = 'V'
            v--
        }
    }
    return string(res)
}