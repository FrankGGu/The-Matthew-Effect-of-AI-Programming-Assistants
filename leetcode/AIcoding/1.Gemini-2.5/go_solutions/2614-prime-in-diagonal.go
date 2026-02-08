func diagonalPrime(nums [][]int) int {
    maxPrime := 0
    n := len(nums)

    for i := 0; i < n; i++ {
        val1 := nums[i][i]
        if isPrime(val1) && val1 > maxPrime {
            maxPrime = val1
        }

        val2 := nums[i][n-1-i]
        if isPrime(val2) && val2 > maxPrime {
            maxPrime = val2
        }
    }

    return maxPrime
}

func isPrime(n int) bool {
    if n <= 1 {
        return false
    }
    if n == 2 || n == 3 {
        return true
    }
    if n%2 == 0 || n%3 == 0 {
        return false
    }
    for i := 5; i*i <= n; i = i + 6 {
        if n%i == 0 || n%(i+2) == 0 {
            return false
        }
    }
    return true
}