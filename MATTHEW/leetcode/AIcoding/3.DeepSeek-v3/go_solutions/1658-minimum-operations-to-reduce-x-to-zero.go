func minOperations(nums []int, x int) int {
    total := 0
    for _, num := range nums {
        total += num
    }
    target := total - x
    if target < 0 {
        return -1
    }
    if target == 0 {
        return len(nums)
    }

    left, sum := 0, 0
    maxLen := -1
    for right := 0; right < len(nums); right++ {
        sum += nums[right]
        for sum > target {
            sum -= nums[left]
            left++
        }
        if sum == target {
            if right - left + 1 > maxLen {
                maxLen = right - left + 1
            }
        }
    }
    if maxLen == -1 {
        return -1
    }
    return len(nums) - maxLen
}