func smallestRangeI(nums []int, k int) int {
    minVal := nums[0]
    maxVal := nums[0]

    for i := 1; i < len(nums); i++ {
        if nums[i] < minVal {
            minVal = nums[i]
        }
        if nums[i] > maxVal {
            maxVal = nums[i]
        }
    }

    // The smallest possible new maximum value is maxVal - k
    // The largest possible new minimum value is minVal + k
    // The new range is (maxVal - k) - (minVal + k)
    // If this difference is negative, it means we can make all elements equal, so the difference is 0.

    diff := (maxVal - k) - (minVal + k)

    if diff < 0 {
        return 0
    }
    return diff
}