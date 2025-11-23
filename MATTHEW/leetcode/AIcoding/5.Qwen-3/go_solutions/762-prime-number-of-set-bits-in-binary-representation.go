package main

func countPrimeSetBits(left int, right int) int {
    isPrime := func(n int) bool {
        if n < 2 {
            return false
        }
        for i := 2; i*i <= n; i++ {
            if n%i == 0 {
                return false
            }
        }
        return true
    }

    count := 0
    for num := left; num <= right; num++ {
        bits := 0
        for n := num; n > 0; n >>= 1 {
            if n&1 == 1 {
                bits++
            }
        }
        if isPrime(bits) {
            count++
        }
    }
    return count
}