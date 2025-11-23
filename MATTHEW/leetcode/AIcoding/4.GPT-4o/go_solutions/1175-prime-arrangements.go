package main

import "math"

func numPrimeArrangements(n int) int {
    const MOD = 1000000007
    primes := 0
    for i := 2; i <= n; i++ {
        if isPrime(i) {
            primes++
        }
    }
    return factorial(primes, MOD) * factorial(n-primes, MOD) % MOD
}

func isPrime(num int) bool {
    if num < 2 {
        return false
    }
    for i := 2; i <= int(math.Sqrt(float64(num))); i++ {
        if num%i == 0 {
            return false
        }
    }
    return true
}

func factorial(n int, mod int) int {
    result := 1
    for i := 2; i <= n; i++ {
        result = (result * i) % mod
    }
    return result
}