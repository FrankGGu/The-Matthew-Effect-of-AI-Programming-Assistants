package main

func maxScoreSightseeing(nums []int) int {
    maxScore := 0
    prev := nums[0]
    for i := 1; i < len(nums); i++ {
        current := nums[i]
        score := prev + current - 1
        if score > maxScore {
            maxScore = score
        }
        if current > prev {
            prev = current
        }
        prev--
    }
    return maxScore
}