func findSubstring(s string, words []string) []int {
    if len(s) == 0 || len(words) == 0 {
        return []int{}
    }

    wordLen := len(words[0])
    wordCount := len(words)
    totalLen := wordLen * wordCount
    wordMap := make(map[string]int)

    for _, word := range words {
        wordMap[word]++
    }

    res := []int{}

    for i := 0; i <= len(s)-totalLen; i++ {
        seen := make(map[string]int)
        j := 0
        for j < wordCount {
            start := i + j*wordLen
            subStr := s[start : start+wordLen]
            if count, exists := wordMap[subStr]; exists {
                seen[subStr]++
                if seen[subStr] > count {
                    break
                }
            } else {
                break
            }
            j++
        }
        if j == wordCount {
            res = append(res, i)
        }
    }

    return res
}