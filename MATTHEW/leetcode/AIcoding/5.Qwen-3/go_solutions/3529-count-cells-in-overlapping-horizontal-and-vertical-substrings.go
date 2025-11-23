package main

func countSubstrings(s string) int {
    n := len(s)
    count := 0
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            if s[i] == s[j] {
                count++
            }
        }
    }
    return count
}