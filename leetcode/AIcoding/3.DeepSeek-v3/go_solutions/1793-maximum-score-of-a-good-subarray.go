func maximumScore(nums []int, k int) int {
    left, right := k, k
    minVal := nums[k]
    maxScore := minVal * (right - left + 1)

    for left > 0 || right < len(nums)-1 {
        if left == 0 {
            right++
        } else if right == len(nums)-1 {
            left--
        } else if nums[left-1] > nums[right+1] {
            left--
        } else {
            right++
        }
        minVal = min(minVal, min(nums[left], nums[right]))
        currentScore := minVal * (right - left + 1)
        if currentScore > maxScore {
            maxScore = currentScore
        }
    }
    return maxScore
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}