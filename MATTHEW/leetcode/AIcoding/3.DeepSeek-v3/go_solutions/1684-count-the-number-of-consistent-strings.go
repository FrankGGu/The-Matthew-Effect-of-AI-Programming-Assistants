func countConsistentStrings(allowed string, words []string) int {
    allowedSet := make(map[rune]bool)
    for _, c := range allowed {
        allowedSet[c] = true
    }

    count := 0
    for _, word := range words {
        consistent := true
        for _, c := range word {
            if !allowedSet[c] {
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