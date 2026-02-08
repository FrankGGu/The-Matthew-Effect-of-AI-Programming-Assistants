func minTime(nums []int, x int) int {
    n := len(nums)
    total := 0
    for _, num := range nums {
        total += num
    }

    target := total - x
    if target < 0 {
        return -1
    }

    left, right := 0, 0
    currSum := 0
    maxLen := -1

    for right < n {
        currSum += nums[right]
        for currSum > target {
            currSum -= nums[left]
            left++
        }
        if currSum == target {
            maxLen = max(maxLen, right-left+1)
        }
        right++
    }

    if maxLen == -1 {
        return -1
    }
    return n - maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}