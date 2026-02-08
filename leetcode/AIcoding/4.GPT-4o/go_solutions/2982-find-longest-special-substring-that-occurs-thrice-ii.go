func longestSpecialSubstring(s string) string {
    n := len(s)
    maxLen := 0
    result := ""

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            substring := s[i:j]
            if isSpecial(substring, s) {
                if len(substring) > maxLen {
                    maxLen = len(substring)
                    result = substring
                }
            }
        }
    }

    return result
}

func isSpecial(substring string, s string) bool {
    count := 0
    for i := 0; i <= len(s)-len(substring); i++ {
        if s[i:i+len(substring)] == substring {
            count++
        }
    }
    return count == 3
}