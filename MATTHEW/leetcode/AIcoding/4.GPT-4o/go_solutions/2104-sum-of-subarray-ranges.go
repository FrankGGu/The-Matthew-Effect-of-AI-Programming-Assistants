func subArrayRanges(nums []int) int64 {
    n := len(nums)
    var result int64
    for i := 0; i < n; i++ {
        minVal := nums[i]
        maxVal := nums[i]
        for j := i; j < n; j++ {
            if nums[j] < minVal {
                minVal = nums[j]
            }
            if nums[j] > maxVal {
                maxVal = nums[j]
            }
            result += int64(maxVal - minVal)
        }
    }
    return result
}