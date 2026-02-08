func minOperations(nums []int, x int) int {
    total := 0
    for _, num := range nums {
        total += num
    }

    target := total - x
    if target < 0 {
        return -1
    }

    maxLength := -1
    currentSum := 0
    left := 0

    for right := 0; right < len(nums); right++ {
        currentSum += nums[right]

        for currentSum > target {
            currentSum -= nums[left]
            left++
        }

        if currentSum == target {
            maxLength = max(maxLength, right-left+1)
        }
    }

    if maxLength == -1 {
        return -1
    }

    return len(nums) - maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}