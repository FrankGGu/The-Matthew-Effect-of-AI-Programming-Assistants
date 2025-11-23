package main

func nonSpecialCount(l int, r int) int {
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
    for num := l; num <= r; num++ {
        if !isPrime(num) {
            count++
        }
    }
    return count
}