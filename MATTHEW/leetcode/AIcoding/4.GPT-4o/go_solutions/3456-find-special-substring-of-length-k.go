func findSpecialSubstring(s string, k int) string {
    n := len(s)
    if n < k {
        return ""
    }

    count := make(map[rune]int)
    for i := 0; i < k; i++ {
        count[rune(s[i])]++
    }

    if isSpecial(count) {
        return s[:k]
    }

    for i := k; i < n; i++ {
        count[rune(s[i])]++
        count[rune(s[i-k])]--

        if count[rune(s[i-k])] == 0 {
            delete(count, rune(s[i-k]))
        }

        if isSpecial(count) {
            return s[i-k+1 : i+1]
        }
    }

    return ""
}

func isSpecial(count map[rune]int) bool {
    uniqueCount := 0
    for _, v := range count {
        if v == 1 {
            uniqueCount++
        }
    }
    return uniqueCount >= 2
}