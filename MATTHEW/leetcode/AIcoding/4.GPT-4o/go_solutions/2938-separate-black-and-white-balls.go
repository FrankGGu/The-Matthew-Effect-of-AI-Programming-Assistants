func sortColors(nums []int) {
    left, right := 0, len(nums)-1
    for i := 0; i <= right; i++ {
        for nums[i] == 2 && i < right {
            nums[i], nums[right] = nums[right], nums[i]
            right--
        }
        if nums[i] == 0 {
            nums[i], nums[left] = nums[left], nums[i]
            left++
        }
    }
}