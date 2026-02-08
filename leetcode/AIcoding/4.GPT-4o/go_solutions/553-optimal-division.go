func optimalDivision(nums []int) string {
    n := len(nums)
    if n == 1 {
        return strconv.Itoa(nums[0])
    }
    if n == 2 {
        return fmt.Sprintf("%d/%d", nums[0], nums[1])
    }
    result := fmt.Sprintf("%d/(%d", nums[0], nums[1])
    for i := 2; i < n; i++ {
        result += fmt.Sprintf("/%d", nums[i])
    }
    result += ")"
    return result
}