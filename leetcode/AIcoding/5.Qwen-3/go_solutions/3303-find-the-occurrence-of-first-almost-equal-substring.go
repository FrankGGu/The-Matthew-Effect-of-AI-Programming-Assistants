package main

func findSubstring(s string, p string) int {
    if len(p) == 0 {
        return 0
    }
    if len(s) < len(p) {
        return -1
    }

    m := len(p)
    n := len(s)
    for i := 0; i <= n - m; i++ {
        match := true
        for j := 0; j < m; j++ {
            if s[i + j] != p[j] {
                match = false
                break
            }
        }
        if match {
            return i
        }
    }
    return -1
}