func makeEqual(words []string) bool {
    charCount := make([]int, 26)
    for _, word := range words {
        for _, char := range word {
            charCount[char-'a']++
        }
    }
    n := len(words)
    for _, count := range charCount {
        if count%n != 0 {
            return false
        }
    }
    return true
}