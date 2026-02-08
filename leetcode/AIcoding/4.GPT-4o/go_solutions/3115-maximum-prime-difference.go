func maximumPrimeDifference(nums []int) int {
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

    primes := []int{}
    for i := 2; i <= 1000000; i++ {
        if isPrime(i) {
            primes = append(primes, i)
        }
    }

    maxDiff := -1
    for _, num := range nums {
        left, right := 0, len(primes)-1
        for left < right {
            mid := left + (right-left)/2
            if primes[mid] < num {
                left = mid + 1
            } else {
                right = mid
            }
        }
        if left > 0 && primes[left-1] < num {
            maxDiff = max(maxDiff, num-primes[left-1])
        }
        if left < len(primes) && primes[left] > num {
            maxDiff = max(maxDiff, primes[left]-num)
        }
    }
    return maxDiff
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}