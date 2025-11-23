func findPrefixScore(nums []int) []int64 {
    n := len(nums)
    result := make([]int64, n)
    maxNum := 0
    prefixSum := int64(0)

    for i := 0; i < n; i++ {
        if nums[i] > maxNum {
            maxNum = nums[i]
        }
        prefixSum += int64(nums[i]) + int64(maxNum)
        result[i] = prefixSum
    }

    return result
}