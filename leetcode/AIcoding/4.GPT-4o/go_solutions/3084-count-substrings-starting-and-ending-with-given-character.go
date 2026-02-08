func countSubstrings(s string, c byte) int {
    count := 0
    total := 0
    for i := 0; i < len(s); i++ {
        if s[i] == c {
            count++
        }
        total += count
    }
    return total
}