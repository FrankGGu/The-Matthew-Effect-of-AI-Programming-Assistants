func findTheString(n int) string {
    result := make([]rune, n)
    for i := 0; i < n; i++ {
        result[i] = 'a' + rune(i%26)
    }
    return string(result)
}