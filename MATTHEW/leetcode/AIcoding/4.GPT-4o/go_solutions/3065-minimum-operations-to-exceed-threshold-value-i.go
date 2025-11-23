func minOperations(nums []int, x int) int {
    target := 0
    for _, num := range nums {
        target += num
    }
    target -= x
    if target < 0 {
        return -1
    }

    left, currentSum, maxLength := 0, 0, -1
    for right, num := range nums {
        currentSum += num
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