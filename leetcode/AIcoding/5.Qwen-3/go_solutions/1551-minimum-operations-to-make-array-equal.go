package main

func minOperations(n int) int {
    operations := 0
    for i := 0; i < n/2; i++ {
        operations += (n - 2*i - 1)
    }
    return operations
}