package main

func getSmallestString(n int, k int) string {
    res := make([]byte, n)
    for i := 0; i < n; i++ {
        res[i] = 'a'
    }
    k -= n
    for i := n - 1; i >= 0 && k > 0; i-- {
        add := min(k, 25)
        res[i] += byte(add)
        k -= add
    }
    return string(res)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}