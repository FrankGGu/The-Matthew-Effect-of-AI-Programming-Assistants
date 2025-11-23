func checkPossibility(nums []int) bool {
    modified := false
    for i := 0; i < len(nums)-1; i++ {
        if nums[i] > nums[i+1] {
            if modified {
                return false
            }
            if i > 0 && nums[i-1] > nums[i+1] {
                nums[i+1] = nums[i]
            } else {
                nums[i] = nums[i+1]
            }
            modified = true
        }
    }
    return true
}