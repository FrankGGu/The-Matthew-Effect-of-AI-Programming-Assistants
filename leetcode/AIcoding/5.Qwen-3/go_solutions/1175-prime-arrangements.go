package main

func numPrimeArrangements(n int) int {
    isPrime := func(num int) bool {
        if num < 2 {
            return false
        }
        for i := 2; i*i <= num; i++ {
            if num%i == 0 {
                return false
            }
        }
        return true
    }

    countPrimes := 0
    for i := 2; i <= n; i++ {
        if isPrime(i) {
            countPrimes++
        }
    }

    primeCount := countPrimes
    nonPrimeCount := n - primeCount

    result := 1
    for i := 2; i <= primeCount; i++ {
        result *= i
    }
    for i := 2; i <= nonPrimeCount; i++ {
        result *= i
    }

    return result
}