func splitArraySameAverage(A []int) bool {
    n := len(A)
    sumA := 0
    for _, num := range A {
        sumA += num
    }

    for k := 1; k <= n/2; k++ {
        if sumA*k%n == 0 {
            target := sumA * k / n
            if canSplit(A, n, k, target) {
                return true
            }
        }
    }
    return false
}

func canSplit(A []int, n, k, target int) bool {
    dp := make([]bool, target+1)
    dp[0] = true
    for _, num := range A {
        for j := target; j >= num; j-- {
            dp[j] = dp[j] || dp[j-num]
        }
    }

    count := 0
    for j := target; j >= 0; j-- {
        if dp[j] {
            count++
            if count == k {
                return true
            }
        }
    }
    return false
}