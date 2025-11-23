import (
    "math"
)

func mostFrequentPrime(nums []int) int {
    primeCount := make(map[int]int)

    for _, num := range nums {
        for num > 1 {
            factor := smallestPrimeFactor(num)
            primeCount[factor]++
            for num % factor == 0 {
                num /= factor
            }
        }
    }

    maxFreq := 0
    result := -1
    for prime, count := range primeCount {
        if count > maxFreq || (count == maxFreq && prime > result) {
            maxFreq = count
            result = prime
        }
    }
    return result
}

func smallestPrimeFactor(x int) int {
    if x%2 == 0 {
        return 2
    }
    for i := 3; i*i <= x; i += 2 {
        if x%i == 0 {
            return i
        }
    }
    return x
}