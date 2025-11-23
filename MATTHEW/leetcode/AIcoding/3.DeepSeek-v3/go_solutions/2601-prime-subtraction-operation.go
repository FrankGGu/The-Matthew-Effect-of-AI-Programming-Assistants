func primeSubOperation(nums []int) bool {
    primes := getPrimes(1000)
    n := len(nums)
    prev := 0
    for i := 0; i < n; i++ {
        x := nums[i]
        if x <= prev {
            return false
        }
        maxP := x - prev - 1
        if maxP <= 0 {
            prev = x
            continue
        }
        idx := sort.SearchInts(primes, maxP)
        if idx < len(primes) && primes[idx] == maxP {
            prev = x - primes[idx]
        } else if idx > 0 {
            prev = x - primes[idx-1]
        } else {
            prev = x
        }
    }
    return true
}

func getPrimes(max int) []int {
    sieve := make([]bool, max+1)
    for i := 2; i <= max; i++ {
        sieve[i] = true
    }
    for i := 2; i*i <= max; i++ {
        if sieve[i] {
            for j := i * i; j <= max; j += i {
                sieve[j] = false
            }
        }
    }
    primes := []int{}
    for i := 2; i <= max; i++ {
        if sieve[i] {
            primes = append(primes, i)
        }
    }
    return primes
}