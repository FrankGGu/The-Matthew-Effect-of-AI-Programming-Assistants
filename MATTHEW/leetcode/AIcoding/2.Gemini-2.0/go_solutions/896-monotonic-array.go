func isMonotonic(nums []int) bool {
    increasing := true
    decreasing := true
    for i := 1; i < len(nums); i++ {
        if nums[i] < nums[i-1] {
            increasing = false
        }
        if nums[i] > nums[i-1] {
            decreasing = false
        }
    }
    return increasing || decreasing
}