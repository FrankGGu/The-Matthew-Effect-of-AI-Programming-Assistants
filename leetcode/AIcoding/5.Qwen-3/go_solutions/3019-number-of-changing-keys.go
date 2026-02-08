package main

func countChanges(s string) int {
    count := 0
    for i := 1; i < len(s); i++ {
        if s[i] != s[i-1] {
            count++
        }
    }
    return count
}