package main

func countOperations(a int, b int) int {
    count := 0
    for a > 0 && b > 0 {
        if a >= b {
            a -= b
        } else {
            b -= a
        }
        count++
    }
    return count
}