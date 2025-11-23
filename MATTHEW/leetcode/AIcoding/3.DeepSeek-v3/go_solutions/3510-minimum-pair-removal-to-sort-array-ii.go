func minOperations(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }
    res := 0
    prev := nums[0]
    for i := 1; i < n; i++ {
        if nums[i] < prev {
            res++
        } else {
            prev = nums[i]
        }
    }
    return res
}