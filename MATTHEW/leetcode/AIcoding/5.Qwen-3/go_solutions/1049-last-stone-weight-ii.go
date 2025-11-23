package main

func lastStoneWeightII(stones []int) int {
    sum := 0
    for _, s := range stones {
        sum += s
    }
    target := sum / 2
    dp := make([]bool, target+1)
    dp[0] = true
    for _, s := range stones {
        for i := target; i >= s; i-- {
            if dp[i-s] {
                dp[i] = true
            }
        }
    }
    for i := target; i >= 0; i-- {
        if dp[i] {
            return sum - 2*i
        }
    }
    return 0
}