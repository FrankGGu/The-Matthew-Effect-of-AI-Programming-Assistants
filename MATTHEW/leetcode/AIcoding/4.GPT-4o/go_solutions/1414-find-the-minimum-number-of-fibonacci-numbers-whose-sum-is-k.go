func findFibonacciNumbers(K int) int {
    fib := []int{1, 2}
    for i := 2; fib[i-1] <= K; i++ {
        fib = append(fib, fib[i-1]+fib[i-2])
    }

    count := 0
    for i := len(fib) - 1; i >= 0 && K > 0; i-- {
        if fib[i] <= K {
            K -= fib[i]
            count++
        }
    }

    return count
}