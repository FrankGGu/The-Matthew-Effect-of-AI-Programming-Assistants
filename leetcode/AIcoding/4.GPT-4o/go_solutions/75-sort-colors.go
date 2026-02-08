func sortColors(nums []int) {
    left, right, current := 0, len(nums)-1, 0
    for current <= right {
        if nums[current] == 0 {
            nums[left], nums[current] = nums[current], nums[left]
            left++
            current++
        } else if nums[current] == 2 {
            nums[current], nums[right] = nums[right], nums[current]
            right--
        } else {
            current++
        }
    }
}