package main

func countSubstrings(s string, c byte) int {
    count := 0
    for i := 0; i < len(s); i++ {
        if s[i] == c {
            count++
        }
    }
    return count * (count + 1) / 2
}