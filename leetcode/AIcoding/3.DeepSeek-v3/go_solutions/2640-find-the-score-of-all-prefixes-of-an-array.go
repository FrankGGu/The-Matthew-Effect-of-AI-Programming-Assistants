func findPrefixScore(nums []int) []int64 {
    n := len(nums)
    res := make([]int64, n)
    maxSoFar := nums[0]
    res[0] = int64(nums[0] + maxSoFar)

    for i := 1; i < n; i++ {
        if nums[i] > maxSoFar {
            maxSoFar = nums[i]
        }
        res[i] = res[i-1] + int64(nums[i] + maxSoFar)
    }

    return res
}