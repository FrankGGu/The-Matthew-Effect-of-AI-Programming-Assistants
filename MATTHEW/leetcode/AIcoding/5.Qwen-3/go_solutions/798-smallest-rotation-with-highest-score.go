package main

func maxScoreSides(nums []int) int {
    n := len(nums)
    score := make([]int, n)
    for i := 0; i < n; i++ {
        a := nums[i]
        left := (i - a + n) % n
        right := (i + 1) % n
        score[left]++
        score[right]--
    }
    maxScore := 0
    currentScore := 0
    for i := 0; i < n; i++ {
        currentScore += score[i]
        if currentScore > maxScore {
            maxScore = currentScore
        }
    }
    return maxScore
}