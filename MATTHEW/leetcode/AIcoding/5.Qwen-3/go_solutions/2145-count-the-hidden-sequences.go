package main

func countTheHiddenSequences(diff []int) int {
    n := len(diff)
    seen := make(map[int]bool)
    current := 0
    seen[current] = true
    for i := 0; i < n; i++ {
        current += diff[i]
        seen[current] = true
    }
    return len(seen)
}