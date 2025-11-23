func alternatingGroups(nums []int) []int {
    n := len(nums)
    result := make([]int, 0)
    for i := 0; i < n; i++ {
        if i%2 == 0 {
            result = append(result, nums[i])
        }
    }
    for i := 1; i < n; i++ {
        if i%2 != 0 {
            result = append(result, nums[i])
        }
    }
    return result
}