package main

func minimumCost(s string) int {
    n := len(s)
    res := 0
    for i := 1; i < n; i++ {
        if s[i] != s[i-1] {
            res += 1
        }
    }
    return res
}