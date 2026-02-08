package main

func numberOfDifferentIntegers(s string) int {
    seen := make(map[string]bool)
    i := 0
    n := len(s)
    for i < n {
        if s[i] >= '0' && s[i] <= '9' {
            j := i
            for j < n && s[j] >= '0' && s[j] <= '9' {
                j++
            }
            seen[s[i:j]] = true
            i = j
        } else {
            i++
        }
    }
    return len(seen)
}