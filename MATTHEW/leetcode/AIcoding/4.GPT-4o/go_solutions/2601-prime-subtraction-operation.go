func primeSubOperation(nums []int) bool {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    isPrime := make([]bool, maxNum+1)
    for i := 2; i <= maxNum; i++ {
        isPrime[i] = true
    }
    for i := 2; i*i <= maxNum; i++ {
        if isPrime[i] {
            for j := i * i; j <= maxNum; j += i {
                isPrime[j] = false
            }
        }
    }

    primes := []int{}
    for i := 2; i <= maxNum; i++ {
        if isPrime[i] {
            primes = append(primes, i)
        }
    }

    for i := len(nums) - 1; i > 0; i-- {
        canSubtract := false
        for _, prime := range primes {
            if nums[i] - prime > nums[i-1] {
                canSubtract = true
                nums[i] -= prime
                break
            }
        }
        if !canSubtract {
            return false
        }
    }
    return true
}