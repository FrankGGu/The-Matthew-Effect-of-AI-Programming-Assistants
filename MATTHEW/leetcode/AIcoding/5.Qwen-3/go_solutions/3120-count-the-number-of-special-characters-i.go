package main

func numberOfSpecialChars(word string) int {
    seen := make(map[rune]bool)
    count := 0

    for _, c := range word {
        if !seen[c] {
            seen[c] = true
            if containsUpper(word, c) {
                count++
            }
        }
    }

    return count
}

func containsUpper(word string, c rune) bool {
    for _, ch := range word {
        if ch == c-32 {
            return true
        }
    }
    return false
}