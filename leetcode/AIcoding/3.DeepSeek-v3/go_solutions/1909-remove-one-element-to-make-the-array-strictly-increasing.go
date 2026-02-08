func canBeIncreasing(nums []int) bool {
    count := 0
    for i := 1; i < len(nums); i++ {
        if nums[i] <= nums[i-1] {
            if count == 1 {
                return false
            }
            count++
            if i > 1 && nums[i] <= nums[i-2] {
                nums[i] = nums[i-1]
            }
        }
    }
    return true
}