package main

func maxOperations(nums []int) int {
    n := len(nums)
    dp := make([]map[int]int, n)
    for i := range dp {
        dp[i] = make(map[int]int)
    }
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            sum := nums[i] + nums[j]
            if i == 0 {
                dp[j][sum] = 1
            } else {
                if val, ok := dp[i-1][sum]; ok {
                    dp[j][sum] = val + 1
                } else {
                    dp[j][sum] = 1
                }
            }
        }
    }
    maxOp := 0
    for i := 0; i < n; i++ {
        for _, v := range dp[i] {
            if v > maxOp {
                maxOp = v
            }
        }
    }
    return maxOp
}