func minOperations(s string) int {
    n := len(s)
    count := 0
    for i := 0; i < n; i++ {
        if s[i] != byte('a'+count) {
            count++
        }
    }
    return count
}