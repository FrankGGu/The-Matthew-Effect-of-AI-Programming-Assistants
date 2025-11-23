func primeSubtractionOperation(nums []int) bool {
    primes := []int{}
    isPrime := make([]bool, 1001)
    for i := 2; i < 1001; i++ {
        isPrime[i] = true
    }
    for i := 2; i*i < 1001; i++ {
        if isPrime[i] {
            for j := i * i; j < 1001; j += i {
                isPrime[j] = false
            }
        }
    }
    for i := 2; i < 1001; i++ {
        if isPrime[i] {
            primes = append(primes, i)
        }
    }

    prev := 0
    for _, num := range nums {
        if num <= prev {
            return false
        }
        for i := len(primes) - 1; i >= 0; i-- {
            if num-primes[i] > prev {
                num -= primes[i]
                break
            }
        }
        if num <= prev {
            return false
        }
        prev = num
    }
    return true
}