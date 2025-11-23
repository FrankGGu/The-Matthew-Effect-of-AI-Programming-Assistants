package main

func lastSubstring(s string) string {
    n := len(s)
    i, j, k := 0, 1, 0
    for j+k < n {
        if s[i+k] == s[j+k] {
            k++
            continue
        } else if s[i+k] < s[j+k] {
            i = max(i+k+1, j)
            j = i + 1
            k = 0
        } else {
            j = j + k + 1
            k = 0
        }
    }
    return s[i:]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}