func isSpecialArray(nums []int) bool {
    for i := 0; i < len(nums); i++ {
        if (nums[i]%2) != (i%2) {
            return false
        }
    }
    return true
}