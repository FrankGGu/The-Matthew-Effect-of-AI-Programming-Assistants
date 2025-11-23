package main

func burstBalloon(nums []int) int {
    n := len(nums)
    nums = append([]int{1}, nums...)
    nums = append(nums, 1)
    n += 2
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for length := 1; length < n-1; length++ {
        for i := 1; i+length < n-1; i++ {
            j := i + length
            dp[i][j] = 0
            for k := i; k <= j; k++ {
                temp := nums[i-1]*nums[j+1]
                if k > i {
                    temp += dp[i][k-1]
                }
                if k < j {
                    temp += dp[k+1][j]
                }
                if temp > dp[i][j] {
                    dp[i][j] = temp
                }
            }
        }
    }
    return dp[1][n-2]
}

func burstBalloons(nums []int) int {
    return burstBalloon(nums)
}