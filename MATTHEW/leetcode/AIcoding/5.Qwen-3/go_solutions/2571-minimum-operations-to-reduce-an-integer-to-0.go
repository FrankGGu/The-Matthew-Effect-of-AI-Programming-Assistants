package main

func minOperations(n int) int {
    operations := 0
    for n > 0 {
        if n%2 == 0 {
            n /= 2
        } else {
            n = (n + 1) / 2
        }
        operations++
    }
    return operations
}