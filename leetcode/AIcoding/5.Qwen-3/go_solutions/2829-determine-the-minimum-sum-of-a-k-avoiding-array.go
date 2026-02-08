package main

func kAvoidingArray(n int, k int) int {
    sum := 0
    for i := 1; i <= n; i++ {
        if i%k != 0 {
            sum += i
        }
    }
    return sum
}