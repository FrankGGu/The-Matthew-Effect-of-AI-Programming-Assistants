func minArray(nums []int) int {
    minVal := nums[0]
    for _, num := range nums {
        if num < minVal {
            minVal = num
        }
    }
    return minVal
}