package main

func countSubstrings(s string, t string) int {
    m, n := len(s), len(t)
    res := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if s[i] == t[j] {
                continue
            }
            diff := 1
            x, y := i-1, j-1
            for x >= 0 && y >= 0 && s[x] == t[y] {
                diff++
                x--
                y--
            }
            x, y = i+1, j+1
            for x < m && y < n && s[x] == t[y] {
                diff++
                x++
                y++
            }
            res += diff
        }
    }
    return res
}