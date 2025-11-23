package main

func minChanges(s string, n int) int {
    count := 0
    for i := 0; i < n; i += 2 {
        if s[i] != s[i+1] {
            count++
        }
    }
    return count
}