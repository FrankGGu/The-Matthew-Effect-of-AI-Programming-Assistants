package main

func numberOfUniqueNumbers(n int) int {
    seen := make(map[int]bool)
    for i := 1; i <= n; i++ {
        seen[i] = true
    }
    return len(seen)
}