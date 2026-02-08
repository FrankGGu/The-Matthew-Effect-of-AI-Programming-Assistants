package main

func splitArray(nums []int) bool {
    n := len(nums)
    if n == 1 {
        return false
    }
    sum := 0
    for _, num := range nums {
        sum += num
    }
    dp := make([]bool, n+1)
    dp[0] = true
    for i := 0; i < n; i++ {
        for j := i; j > 0; j-- {
            if dp[j-1] && (sum*j)%n == 0 && (sum*j)/n == (sum - nums[i])*j/(n-j) {
                return true
            }
            if dp[j-1] {
                dp[j] = true
            }
        }
    }
    return false
}