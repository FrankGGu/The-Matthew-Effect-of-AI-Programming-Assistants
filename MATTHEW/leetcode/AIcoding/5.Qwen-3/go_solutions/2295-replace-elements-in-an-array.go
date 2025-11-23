package main

func arrayReplace(a []int, indices []int, sources []string, targets []string) []int {
    n := len(a)
    m := len(indices)
    res := make([]int, n)
    for i := 0; i < n; i++ {
        res[i] = a[i]
    }
    for i := m - 1; i >= 0; i-- {
        idx := indices[i]
        src := sources[i]
        tgt := targets[i]
        if idx+len(src) <= n && string(a[idx:idx+len(src)]) == src {
            for j := idx; j < idx+len(src); j++ {
                res[j] = -1
            }
            res[idx] = tgt
        }
    }
    return res
}