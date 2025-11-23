func isMonotonic(nums []int) bool {
    isIncreasing := true
    isDecreasing := true

    for i := 0; i < len(nums)-1; i++ {
        if nums[i] > nums[i+1] {
            isIncreasing = false
        }
        if nums[i] < nums[i+1] {
            isDecreasing = false
        }
    }

    return isIncreasing || isDecreasing
}