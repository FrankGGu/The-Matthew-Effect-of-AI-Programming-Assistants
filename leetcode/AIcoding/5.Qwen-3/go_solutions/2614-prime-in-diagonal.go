package main

func diagonalPrime(nums [][]int) int {
    max := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        if isPrime(nums[i][i]) && nums[i][i] > max {
            max = nums[i][i]
        }
        if isPrime(nums[i][n-1-i]) && nums[i][n-1-i] > max {
            max = nums[i][n-1-i]
        }
    }
    return max
}

func isPrime(num int) bool {
    if num < 2 {
        return false
    }
    for i := 2; i*i <= num; i++ {
        if num%i == 0 {
            return false
        }
    }
    return true
}