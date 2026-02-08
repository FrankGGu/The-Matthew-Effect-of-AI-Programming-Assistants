func minOperations(nums []int) int {
    n := len(nums)
    res := 0
    flip := 0
    for i := 0; i < n; i++ {
        if (nums[i] + flip) % 2 == 0 {
            res++
            flip++
        }
    }
    return res
}