func restoreString(s string, indices []int) string {
    result := make([]byte, len(s))
    for i, idx := range indices {
        result[idx] = s[i]
    }
    return string(result)
}