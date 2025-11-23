func findSubstring(s string, words []string) []int {
    if len(words) == 0 || len(s) == 0 {
        return []int{}
    }

    wordLen := len(words[0])
    totalLen := wordLen * len(words)
    wordCount := make(map[string]int)
    for _, word := range words {
        wordCount[word]++
    }

    result := []int{}

    for i := 0; i <= len(s)-totalLen; i++ {
        seen := make(map[string]int)
        j := 0
        for j < len(words) {
            start := i + j * wordLen
            end := start + wordLen
            if end > len(s) {
                break
            }
            currentWord := s[start:end]
            if _, exists := wordCount[currentWord]; !exists {
                break
            }
            seen[currentWord]++
            if seen[currentWord] > wordCount[currentWord] {
                break
            }
            j++
        }
        if j == len(words) {
            result = append(result, i)
        }
    }

    return result
}