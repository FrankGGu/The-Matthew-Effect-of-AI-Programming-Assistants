package main

func findMinimumOperations(s string) int {
    if len(s) == 0 {
        return 0
    }
    count := 0
    prev := s[0]
    for i := 1; i < len(s); i++ {
        if s[i] != prev {
            count++
            prev = s[i]
        }
    }
    return count + 1
}