func restoreString(s string, indices []int) string {
    n := len(s)
    result := make([]byte, n)

    for i := 0; i < n; i++ {
        // The character at s[i] moves to the position indices[i]
        result[indices[i]] = s[i]
    }

    return string(result)
}