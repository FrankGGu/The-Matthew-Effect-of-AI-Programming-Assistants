func findKthCharacter(s string, k int64) byte {
    for len(s) < int(k) {
        var next strings.Builder
        for _, ch := range s {
            if ch == '0' {
                next.WriteString("1")
            } else {
                next.WriteString("0")
            }
        }
        s += next.String()
    }
    return s[k-1]
}