func smallestSubstring(s string) string {
    if len(s) == 0 {
        return ""
    }
    minLen := len(s)
    start := 0
    for i := 0; i < len(s); {
        j := i
        for j < len(s) && s[j] == s[i] {
            j++
        }
        if j - i < minLen {
            minLen = j - i
            start = i
        }
        i = j
    }
    return s[start : start+minLen]
}