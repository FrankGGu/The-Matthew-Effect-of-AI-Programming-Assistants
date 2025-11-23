package main

func maxXorProduct(n int64, m int64, a []int64, b []int64) int64 {
    i, j := 0, 0
    res := int64(0)
    for i < len(a) && j < len(b) {
        if a[i] > b[j] {
            res ^= a[i]
            i++
        } else {
            res ^= b[j]
            j++
        }
    }
    for i < len(a) {
        res ^= a[i]
        i++
    }
    for j < len(b) {
        res ^= b[j]
        j++
    }
    return res
}