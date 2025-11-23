package main

func minSteps(n int) int {
    if n == 1 {
        return 0
    }
    for i := 2; i <= n; i++ {
        if n%i == 0 {
            return minSteps(n/i) + i
        }
    }
    return 0
}