package main

func maxScore(nums []int) int {
    sort.Ints(nums)
    score := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] > 0 {
            score += nums[i]
        }
    }
    return score
}