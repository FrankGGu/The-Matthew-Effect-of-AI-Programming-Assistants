func findKthCharacter(s string, k int) byte {
    for len(s) < k {
        var next strings.Builder
        for _, ch := range s {
            if ch == '0' {
                next.WriteString("01")
            } else {
                next.WriteString("10")
            }
        }
        s = next.String()
    }
    return s[k-1]
}