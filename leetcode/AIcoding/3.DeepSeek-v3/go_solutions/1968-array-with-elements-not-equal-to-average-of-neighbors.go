func rearrangeArray(nums []int) []int {
    n := len(nums)
    for i := 1; i < n-1; i++ {
        if (nums[i-1] < nums[i] && nums[i] < nums[i+1]) || (nums[i-1] > nums[i] && nums[i] > nums[i+1]) {
            nums[i], nums[i+1] = nums[i+1], nums[i]
        }
    }
    return nums
}