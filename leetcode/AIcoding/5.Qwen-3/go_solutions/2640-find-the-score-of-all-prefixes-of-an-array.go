package main

func sumScores(nums []int) int {
    n := len(nums)
    scores := make([]int, n)
    scores[0] = nums[0]
    for i := 1; i < n; i++ {
        scores[i] = scores[i-1] + nums[i]
    }
    total := 0
    for i := 0; i < n; i++ {
        total += scores[i]
    }
    return total
}