func splitArray(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)
    primeMin := make(map[int]int)

    for i := 0; i < n; i++ {
        dp[i] = i + 1
        factors := getPrimeFactors(nums[i])
        minVal := dp[i]
        for p := range factors {
            if val, exists := primeMin[p]; exists {
                if val < minVal {
                    minVal = val
                }
            }
            primeMin[p] = minVal
        }
        dp[i] = minVal
    }

    return dp[n-1]
}

func getPrimeFactors(x int) map[int]bool {
    factors := make(map[int]bool)
    if x == 1 {
        return factors
    }

    for i := 2; i*i <= x; i++ {
        for x%i == 0 {
            factors[i] = true
            x /= i
        }
    }
    if x > 1 {
        factors[x] = true
    }
    return factors
}