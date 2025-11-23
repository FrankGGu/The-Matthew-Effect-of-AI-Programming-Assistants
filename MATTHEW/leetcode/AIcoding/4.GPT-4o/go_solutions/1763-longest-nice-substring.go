func longestNiceSubstring(s string) string {
    maxLen := 0
    start := 0

    for i := 0; i < len(s); i++ {
        for j := i + 1; j <= len(s); j++ {
            substring := s[i:j]
            if isNice(substring) {
                if len(substring) > maxLen {
                    maxLen = len(substring)
                    start = i
                }
            }
        }
    }
    return s[start : start+maxLen]
}

func isNice(s string) bool {
    charMap := make(map[rune]bool)
    for _, ch := range s {
        charMap[ch] = true
    }
    for _, ch := range s {
        if !charMap[rune(ch+32)] && !charMap[rune(ch-32)] {
            return false
        }
    }
    return true
}