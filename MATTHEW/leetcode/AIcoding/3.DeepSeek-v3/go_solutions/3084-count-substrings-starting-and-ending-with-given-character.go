func countSubstrings(s string, c byte) int64 {
    count := 0
    for i := 0; i < len(s); i++ {
        if s[i] == c {
            count++
        }
    }
    return int64(count * (count + 1) / 2)
}