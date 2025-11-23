package main

func minMovesToConvert(s string) int {
    n := len(s)
    res := 0
    for i := 0; i < n; i++ {
        if s[i] == 'X' {
            res++
            i += 2
        }
    }
    return res
}