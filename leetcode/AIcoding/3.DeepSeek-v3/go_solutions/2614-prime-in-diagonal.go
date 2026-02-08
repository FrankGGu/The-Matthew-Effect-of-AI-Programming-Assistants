func diagonalPrime(nums [][]int) int {
    maxPrime := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        if isPrime(nums[i][i]) && nums[i][i] > maxPrime {
            maxPrime = nums[i][i]
        }
        if isPrime(nums[i][n-1-i]) && nums[i][n-1-i] > maxPrime {
            maxPrime = nums[i][n-1-i]
        }
    }
    return maxPrime
}

func isPrime(num int) bool {
    if num <= 1 {
        return false
    }
    if num == 2 {
        return true
    }
    if num%2 == 0 {
        return false
    }
    for i := 3; i*i <= num; i += 2 {
        if num%i == 0 {
            return false
        }
    }
    return true
}