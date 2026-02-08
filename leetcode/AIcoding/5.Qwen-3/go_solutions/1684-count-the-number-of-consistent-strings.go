package main

func countConsistentStrings(allowed string, words []string) int {
    allowedSet := make(map[rune]bool)
    for _, c := range allowed {
        allowedSet[c] = true
    }
    count := 0
    for _, word := range words {
        valid := true
        for _, c := range word {
            if !allowedSet[c] {
                valid = false
                break
            }
        }
        if valid {
            count++
        }
    }
    return count
}