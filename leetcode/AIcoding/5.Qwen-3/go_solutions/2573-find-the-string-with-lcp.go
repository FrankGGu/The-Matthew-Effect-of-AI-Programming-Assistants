package main

func findTheString(lcp [][]int) string {
    n := len(lcp)
    s := make([]byte, n)
    for i := range s {
        s[i] = 'a'
    }

    for i := 0; i < n; i++ {
        if s[i] == 'a' {
            for j := i + 1; j < n; j++ {
                if lcp[i][j] > 0 {
                    if s[j] == 'a' {
                        s[j] = s[i] + 1
                    } else if s[j] != s[i] {
                        return ""
                    }
                }
            }
        }
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if i == j {
                continue
            }
            if lcp[i][j] > 0 {
                if s[i] != s[j] {
                    return ""
                }
            }
        }
    }

    return string(s)
}