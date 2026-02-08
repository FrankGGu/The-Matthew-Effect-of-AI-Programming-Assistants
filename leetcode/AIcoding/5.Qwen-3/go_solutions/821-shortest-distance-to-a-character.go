package main

func shortestToChar(s string, c byte) []int {
    n := len(s)
    res := make([]int, n)
    prev := -n

    for i := 0; i < n; i++ {
        if s[i] == c {
            prev = i
        }
        res[i] = i - prev
    }

    for i := n - 1; i >= 0; i-- {
        if s[i] == c {
            prev = i
        }
        res[i] = min(res[i], prev - i)
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}