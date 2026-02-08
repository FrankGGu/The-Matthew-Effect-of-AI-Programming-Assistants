func countSpecialSubstrings(s string, k int) int {
    n := len(s)
    count := 0
    for i := 0; i <= n-k; i++ {
        sub := s[i : i+k]
        if isSpecial(sub) {
            count++
            i += k - 1
        }
    }
    return count
}

func isSpecial(s string) bool {
    freq := make(map[rune]int)
    for _, c := range s {
        freq[c]++
        if freq[c] > 1 {
            return false
        }
    }
    return true
}