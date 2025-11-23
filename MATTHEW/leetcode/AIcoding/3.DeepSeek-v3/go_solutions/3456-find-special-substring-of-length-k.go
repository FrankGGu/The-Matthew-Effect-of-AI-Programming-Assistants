func findSpecialSubstring(s string, k int) string {
    n := len(s)
    if n < k {
        return ""
    }

    for i := 0; i <= n-k; i++ {
        substr := s[i:i+k]
        if isValid(substr) {
            return substr
        }
    }

    return ""
}

func isValid(s string) bool {
    freq := make(map[rune]int)
    for _, ch := range s {
        freq[ch]++
        if freq[ch] > 1 {
            return false
        }
    }
    return true
}