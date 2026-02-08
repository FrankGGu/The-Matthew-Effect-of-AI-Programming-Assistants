func minOperations(nums []int) int {
    n := len(nums)
    sort.Ints(nums)

    maxNum := 0
    for i := 0; i < n; i++ {
        if nums[i] < i+1 {
            maxNum += i + 1 - nums[i]
        }
    }
    return maxNum
}