func smallestString(s string, k int) string {
    b := []byte(s)
    n := len(b)

    for i := 0; i < n && k > 0; i++ {
        if b[i] > 'a' {
            change := min(k, int(b[i]-'a'))
            b[i] -= byte(change)
            k -= change
        }
    }

    return string(b)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}