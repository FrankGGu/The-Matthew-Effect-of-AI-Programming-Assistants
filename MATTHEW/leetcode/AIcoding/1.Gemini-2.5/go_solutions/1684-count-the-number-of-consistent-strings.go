func countConsistentStrings(allowed string, words []string) int {
    allowedChars := make([]bool, 26)
    for _, char := range allowed {
        allowedChars[char-'a'] = true
    }

    consistentCount := 0
    for _, word := range words {
        isConsistent := true
        for _, char := range word {
            if !allowedChars[char-'a'] {
                isConsistent = false
                break
            }
        }
        if isConsistent {
            consistentCount++
        }
    }

    return consistentCount
}