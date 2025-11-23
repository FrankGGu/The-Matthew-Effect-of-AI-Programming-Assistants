func countSubarrays(nums []int) int {
    n := len(nums)
    totalCount := 0

    for i := 0; i < n; i++ {
        maxVal := nums[i]
        for j := i; j < n; j++ {
            if nums[j] > maxVal {
                break
            }
            maxVal = nums[j]
            totalCount++
        }
    }

    return totalCount
}