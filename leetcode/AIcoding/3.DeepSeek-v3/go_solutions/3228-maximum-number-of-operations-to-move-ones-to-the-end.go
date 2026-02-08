func moveOnesToEnd(nums []int) int {
    left, right := 0, len(nums)-1
    operations := 0

    for left < right {
        if nums[left] == 1 && nums[right] != 1 {
            nums[left], nums[right] = nums[right], nums[left]
            operations++
            left++
            right--
        } else {
            if nums[left] != 1 {
                left++
            }
            if nums[right] == 1 {
                right--
            }
        }
    }

    return operations
}