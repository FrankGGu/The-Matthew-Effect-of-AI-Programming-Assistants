package main

func findMinimumOperations(s string) int {
    n := len(s)
    if n%2 != 0 {
        return -1
    }
    count := 0
    for i := 0; i < n; i += 2 {
        if s[i] == s[i+1] {
            count++
        } else {
            return -1
        }
    }
    return count
}