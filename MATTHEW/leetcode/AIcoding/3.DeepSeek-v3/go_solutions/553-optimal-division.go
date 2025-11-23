func optimalDivision(nums []int) string {
    n := len(nums)
    if n == 1 {
        return fmt.Sprintf("%d", nums[0])
    }
    if n == 2 {
        return fmt.Sprintf("%d/%d", nums[0], nums[1])
    }
    res := fmt.Sprintf("%d/(%d", nums[0], nums[1])
    for i := 2; i < n; i++ {
        res += fmt.Sprintf("/%d", nums[i])
    }
    res += ")"
    return res
}