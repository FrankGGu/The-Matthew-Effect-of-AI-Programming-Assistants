func findPrefixScore(nums []int) []int64 {
    n := len(nums)
    res := make([]int64, n)
    maxVal := 0
    sum := int64(0)
    for i := 0; i < n; i++ {
        if nums[i] > maxVal {
            maxVal = nums[i]
        }
        sum += int64(nums[i] + maxVal)
        res[i] = sum
    }
    return res
}