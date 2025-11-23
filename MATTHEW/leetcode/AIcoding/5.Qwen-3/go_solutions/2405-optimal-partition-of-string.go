package main

func partitionString(s string) int {
    seen := make(map[rune]bool)
    count := 1
    for _, c := range s {
        if seen[c] {
            count++
            seen = make(map[rune]bool)
            seen[c] = true
        } else {
            seen[c] = true
        }
    }
    return count
}