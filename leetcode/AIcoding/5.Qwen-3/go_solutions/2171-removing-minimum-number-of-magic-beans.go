package main

func removeMinimumMagicBeans(beans []int) int {
    sort.Ints(beans)
    n := len(beans)
    total := 0
    for _, b := range beans {
        total += b
    }
    res := total
    for i := 0; i < n; i++ {
        res = min(res, total - beans[i]*(n-i))
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}