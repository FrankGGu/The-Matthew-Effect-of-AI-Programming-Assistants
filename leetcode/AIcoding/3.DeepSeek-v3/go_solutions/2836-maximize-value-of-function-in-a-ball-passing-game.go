func getMaxFunctionValue(receiver []int, k int64) int64 {
    n := len(receiver)
    m := 0
    for kk := k; kk > 0; kk >>= 1 {
        m++
    }
    f := make([][]int, m)
    sum := make([][]int64, m)
    for i := 0; i < m; i++ {
        f[i] = make([]int, n)
        sum[i] = make([]int64, n)
    }
    for j := 0; j < n; j++ {
        f[0][j] = receiver[j]
        sum[0][j] = int64(receiver[j])
    }
    for i := 1; i < m; i++ {
        for j := 0; j < n; j++ {
            f[i][j] = f[i-1][f[i-1][j]]
            sum[i][j] = sum[i-1][j] + sum[i-1][f[i-1][j]]
        }
    }
    res := int64(0)
    for j := 0; j < n; j++ {
        pos := j
        s := int64(j)
        for i := 0; i < m; i++ {
            if (k>>uint(i))&1 != 0 {
                s += sum[i][pos]
                pos = f[i][pos]
            }
        }
        if s > res {
            res = s
        }
    }
    return res
}