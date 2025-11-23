func minOperations(nums []int, x int) int {
    total := 0
    for _, num := range nums {
        total += num
    }
    target := total - x
    n := len(nums)
    maxLen := -1
    currentSum := 0
    left := 0

    for right := 0; right < n; right++ {
        currentSum += nums[right]

        for currentSum > target && left <= right {
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

    return n - maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}