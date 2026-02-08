func findSubstring(s string, words []string) []int {
    if len(words) == 0 || len(words[0]) == 0 {
        return []int{}
    }

    wordLen := len(words[0])
    numWords := len(words)
    totalLen := wordLen * num