func findIntegers(n int) int {
    fib := make([]int, 32)
    fib[0], fib[1] = 1, 2
    for i := 2; i < 32; i++ {
        fib[i] = fib[i-1] + fib[i-2]
    }

    count := 0
    prevBit := 0
    for i := 31; i >= 0; i-- {
        if (n & (1 << i)) != 0 {
            count += fib[i]
            if prevBit == 1 {
                return count
            }
            prevBit = 1
        } else {
            prevBit = 0
        }
    }

    return count + 1
}