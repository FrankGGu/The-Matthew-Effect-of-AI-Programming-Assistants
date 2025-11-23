func numOfStrings(patterns []string, word string) int {
    count := 0
    for _, pattern := range patterns {
        if canFormSubstring(pattern, word) {
            count++
        }
    }
    return count
}

func canFormSubstring(pattern string, word string) bool {
    m := make(map[rune]struct{})
    for _, ch := range word {
        m[ch] = struct{}{}
    }
    for _, ch := range pattern {
        if _, exists := m[ch]; !exists {
            return false
        }
    }
    return true
}