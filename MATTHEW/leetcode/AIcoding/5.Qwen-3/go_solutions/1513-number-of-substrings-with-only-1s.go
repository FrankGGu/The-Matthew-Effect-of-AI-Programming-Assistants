package main

func numSubstrings(s string) int {
    count := 0
    for i := 0; i < len(s); i++ {
        if s[i] == '1' {
            j := i
            for j < len(s) && s[j] == '1' {
                count++
                j++
            }
        }
    }
    return count
}