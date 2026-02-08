func bestRotation(nums []int) int {
    n := len(nums)
    score := make([]int, n)

    for i := 0; i < n; i++ {
        left := (i - nums[i] + 1 + n) % n
        right := (i + 1) % n
        score[left]++
        if right != 0 {
            score[right]--
        }
    }

    maxScore, maxIndex, currentScore := 0, 0, 0
    for i := 0; i < n; i++ {
        currentScore += score[i]
        if currentScore > maxScore {
            maxScore = currentScore
            maxIndex = i
        }
    }

    return maxIndex
}