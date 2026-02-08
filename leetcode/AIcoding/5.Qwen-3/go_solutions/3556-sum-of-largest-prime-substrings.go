package main

func sumOfLargestPrimeSubstrings(s string) int {
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

    maxPrime := 0
    for i := 0; i < len(s); i++ {
        for j := i + 1; j <= len(s); j++ {
            num, _ := strconv.Atoi(s[i:j])
            if isPrime(num) && num > maxPrime {
                maxPrime = num
            }
        }
    }
    return maxPrime
}