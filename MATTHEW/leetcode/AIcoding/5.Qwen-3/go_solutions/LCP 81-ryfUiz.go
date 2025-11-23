package main

func makeTheIntegerZero(n int, k int) int {
    for i := 0; i < k; i++ {
        if n == 0 {
            return i
        }
        n = n - 1
        if n >= 0 {
            n = n ^ 1
        }
    }
    return -1
}