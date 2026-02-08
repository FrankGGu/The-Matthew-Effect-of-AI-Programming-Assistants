func maximumScore(nums []int, k int) int {
    n := len(nums)
    left := k
    right := k
    minVal := nums[k]
    maxScore := nums[k]

    for left >= 0 || right < n {
        if right >= n || (left > 0 && nums[left-1] >= nums[right]) {
            left--
            if left >= 0 {
                minVal = min(minVal, nums[left])
            }
        } else {
            right++
            if right < n {
                minVal = min(minVal, nums[right])
            }
        }
        maxScore = max(maxScore, minVal*(right-left))
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