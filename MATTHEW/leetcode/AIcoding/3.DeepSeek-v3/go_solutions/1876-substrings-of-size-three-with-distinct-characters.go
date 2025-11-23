func countGoodSubstrings(s string) int {
    count := 0
    for i := 0; i <= len(s)-3; i++ {
        a, b, c := s[i], s[i+1], s[i+2]
        if a != b && b != c && a != c {
            count++
        }
    }
    return count
}