func encryptedNumber(nums []int) []int {
    n := len(nums)
    result := make([]int, n)
    for i := 0; i < n; i++ {
        result[i] = nums[i] * 2
    }
    return result
}