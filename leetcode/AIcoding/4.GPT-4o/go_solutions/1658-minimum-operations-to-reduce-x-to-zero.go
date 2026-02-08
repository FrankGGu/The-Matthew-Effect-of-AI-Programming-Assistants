func minOperations(nums []int, x int) int {
    total := 0
    for _, num := range nums {
        total += num
    }

    target := total - x
    if target < 0 {
        return -1
    }

    left, maxLen, currentSum := 0, -1, 0
    for right := 0; right < len(nums); right++ {
        currentSum += nums[right]
        for currentSum > target {
            currentSum -= nums[left]
            left++
        }
        if currentSum == target {
            maxLen = max(maxLen, right-left+1)
        }
    }

    if maxLen == -1 {
        return -1
    }

    return len(nums) - maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}