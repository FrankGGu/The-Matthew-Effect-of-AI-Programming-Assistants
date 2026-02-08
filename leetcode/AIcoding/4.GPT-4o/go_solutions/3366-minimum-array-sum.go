func minArraySum(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    sum := 0
    for i := 0; i < n; i++ {
        sum += nums[i]
    }

    return sum
}