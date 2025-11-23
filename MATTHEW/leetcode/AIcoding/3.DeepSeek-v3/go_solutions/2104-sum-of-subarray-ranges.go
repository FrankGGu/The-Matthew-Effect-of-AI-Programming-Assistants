func subArrayRanges(nums []int) int64 {
    n := len(nums)
    var sum int64 = 0

    for i := 0; i < n; i++ {
        minVal := nums[i]
        maxVal := nums[i]
        for j := i + 1; j < n; j++ {
            if nums[j] < minVal {
                minVal = nums[j]
            } else if nums[j] > maxVal {
                maxVal = nums[j]
            }
            sum += int64(maxVal - minVal)
        }
    }

    return sum
}