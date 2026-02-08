func countConsistentStrings(allowed string, words []string) int {
    allowedSet := make(map[rune]struct{})
    for _, char := range allowed {
        allowedSet[char] = struct{}{}
    }

    count := 0
    for _, word := range words {
        consistent := true
        for _, char := range word {
            if _, exists := allowedSet[char]; !exists {
                consistent = false
                break
            }
        }
        if consistent {
            count++
        }
    }

    return count
}