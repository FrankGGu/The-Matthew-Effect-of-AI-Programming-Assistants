package main

func maxValueOfKCoinsFromPiles(piles [][]int, k int) int {
    dp := make([]int, k+1)
    for _, pile := range piles {
        for i := k; i >= 0; i-- {
            for j := 1; j <= len(pile) && i+j <= k; j++ {
                dp[i+j] = max(dp[i+j], dp[i]+pile[j-1])
            }
        }
    }
    return dp[k]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}