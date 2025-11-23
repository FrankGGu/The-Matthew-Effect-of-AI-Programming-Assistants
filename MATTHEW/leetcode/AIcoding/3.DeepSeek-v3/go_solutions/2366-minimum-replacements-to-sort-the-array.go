func minimumReplacement(nums []int) int64 {
    n := len(nums)
    res := int64(0)
    prev := nums[n-1]
    for i := n-2; i >= 0; i-- {
        if nums[i] <= prev {
            prev = nums[i]
            continue
        }
        parts := (nums[i] + prev - 1) / prev
        res += int64(parts - 1)
        prev = nums[i] / parts
    }
    return res
}