package main

func findSubarrays(s string) int {
    n := len(s)
    if n < 3 {
        return 0
    }
    seen := make(map[string]bool)
    count := 0
    for i := 0; i <= n-3; i++ {
        sub := s[i : i+3]
        if !seen[sub] {
            seen[sub] = true
            count++
        }
    }
    return count
}