package main

func findMinFibonacciNumbers(k int) int {
    fib := []int{1, 1}
    for fib[len(fib)-1] < k {
        fib = append(fib, fib[len(fib)-1]+fib[len(fib)-2])
    }
    count := 0
    for i := len(fib) - 1; i >= 0; i-- {
        if k >= fib[i] {
            k -= fib[i]
            count++
        }
        if k == 0 {
            break
        }
    }
    return count
}