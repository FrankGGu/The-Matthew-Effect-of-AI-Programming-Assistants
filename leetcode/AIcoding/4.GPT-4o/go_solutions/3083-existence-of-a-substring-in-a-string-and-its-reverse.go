func isSubsequence(s string, t string) bool {
    m, n := len(s), len(t)
    j := 0
    for i := 0; i < n && j < m; i++ {
        if t[i] == s[j] {
            j++
        }
    }
    return j == m
}

func isReverse(s string, t string) bool {
    m, n := len(s), len(t)
    j := m - 1
    for i := 0; i < n && j >= 0; i++ {
        if t[i] == s[j] {
            j--
        }
    }
    return j < 0
}

func isSubstringAndReverse(s string, t string) bool {
    return isSubsequence(s, t) || isReverse(s, t)
}

func checkExistence(s string, t string) bool {
    return isSubstringAndReverse(s, t)
}