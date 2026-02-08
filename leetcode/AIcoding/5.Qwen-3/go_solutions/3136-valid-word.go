package main

func isValidWord(word string) bool {
    if len(word) < 2 {
        return false
    }
    hasUpper := false
    hasLower := false
    hasDigit := false
    for _, c := range word {
        if c >= 'A' && c <= 'Z' {
            hasUpper = true
        } else if c >= 'a' && c <= 'z' {
            hasLower = true
        } else if c >= '0' && c <= '9' {
            hasDigit = true
        } else {
            return false
        }
    }
    return hasUpper && hasLower && hasDigit
}