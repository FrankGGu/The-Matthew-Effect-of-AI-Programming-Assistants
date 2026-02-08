package main

func maximumNumberofDistinctPrimes(num int) int {
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

    getPrimes := func(n int) []int {
        primes := []int{}
        for i := 2; i <= n; i++ {
            if isPrime(i) {
                primes = append(primes, i)
            }
        }
        return primes
    }

    primes := getPrimes(num)

    count := 0
    for _, p := range primes {
        if num%p == 0 {
            count++
            num /= p
        }
    }

    return count
}