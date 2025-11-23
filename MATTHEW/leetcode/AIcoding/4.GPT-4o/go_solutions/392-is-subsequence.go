func isSubsequence(s string, t string) bool {
    sLen, tLen := len(s), len(t)
    if sLen == 0 {
        return true
    }
    if tLen == 0 {
        return false
    }

    i, j := 0, 0
    for i < sLen && j < tLen {
        if s[i] == t[j] {
            i++
        }
        j++
    }
    return i == sLen
}