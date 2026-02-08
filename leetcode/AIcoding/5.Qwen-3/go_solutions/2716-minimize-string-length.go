package main

func minimizeStringLength(s string) int {
    seen := make(map[rune]bool)
    result := 0
    for _, c := range s {
        if !seen[c] {
            seen[c] = true
            result++
        }
    }
    return result
}