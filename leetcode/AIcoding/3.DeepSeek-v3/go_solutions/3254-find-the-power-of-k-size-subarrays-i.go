func sumOfPowers(nums []int, k int) int64 {
    n := len(nums)
    var total int64 = 0
    for i := 0; i <= n-k; i++ {
        min := nums[i]
        for j := i; j < i+k; j++ {
            if nums[j] < min {
                min = nums[j]
            }
        }
        total += int64(min * min)
    }
    return total
}