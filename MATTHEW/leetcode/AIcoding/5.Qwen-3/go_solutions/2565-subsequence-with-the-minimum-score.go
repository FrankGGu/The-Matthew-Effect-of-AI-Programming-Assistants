package main

func minSubsequenceLen(s string, t string) int {
    m, n := len(s), len(t)
    if m < n {
        return -1
    }
    i, j := 0, 0
    res := 0
    for i < m {
        if s[i] == t[j] {
            i++
            j++
            if j == n {
                break
            }
        } else {
            i++
        }
    }
    if j != n {
        return -1
    }
    i = m - 1
    j = n - 1
    for i >= 0 {
        if s[i] == t[j] {
            i--
            j--
            if j < 0 {
                break
            }
        } else {
            i--
        }
    }
    return m - i - 1
}