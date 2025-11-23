func maximumNumberOfStringPairs(words []string) int {
    seen := make(map[string]bool)
    count := 0
    for _, word := range words {
        reversed := reverse(word)
        if seen[reversed] {
            count++
        }
        seen[word] = true
    }
    return count
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}