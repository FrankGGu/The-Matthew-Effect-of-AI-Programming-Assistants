func maximumScore(nums []int, k int) int {
    n := len(nums)
    left, right := k, k
    maxScore := nums[k]

    for left > 0 || right < n-1 {
        if left == 0 {
            right++
        } else if right == n-1 {
            left--
        } else if nums[left-1] < nums[right+1] {
            right++
        } else {
            left--
        }
        maxScore = max(maxScore, min(nums[left], nums[right])*(right-left+1))
    }

    return maxScore
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}