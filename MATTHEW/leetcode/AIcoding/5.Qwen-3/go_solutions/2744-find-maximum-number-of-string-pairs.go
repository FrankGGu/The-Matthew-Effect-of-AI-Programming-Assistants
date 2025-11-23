package main

func maximumNumberOfStringPairs(_ string) int {
    seen := make(map[rune]bool)
    count := 0
    for _, ch := range _ {
        if seen[ch] {
            count++
        } else {
            seen[ch] = true
        }
    }
    return count
}