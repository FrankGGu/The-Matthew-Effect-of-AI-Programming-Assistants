func minOperations(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }

    left := 0
    right := n - 1
    operations := 0

    for left < right {
        if nums[left] == nums[right] {
            left++
            right--
        } else if nums[left] < nums[right] {
            left++
            nums[left] += nums[left-1]
            operations++
        } else {
            right--
            nums[right] += nums[right+1]
            operations++
        }
    }

    return operations
}