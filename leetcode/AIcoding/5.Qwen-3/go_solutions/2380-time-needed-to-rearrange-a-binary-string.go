package main

func minTimeToRearrange(s string) int {
    n := len(s)
    res := 0
    for i := 0; i < n; i++ {
        if s[i] == '1' {
            res += i
        }
    }
    return res
}