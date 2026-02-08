func generateLexicographicallySmallestString(n int) string {
    result := make([]byte, n)
    for i := 0; i < n; i++ {
        if i%2 == 0 {
            result[i] = 'a'
        } else {
            result[i] = 'b'
        }
    }
    return string(result)
}