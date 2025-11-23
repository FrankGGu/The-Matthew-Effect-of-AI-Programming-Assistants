func alternatingGroups(nums []int) []int {
    n := len(nums)
    result := make([]int, 0)
    group := 0
    for i := 0; i < n; i++ {
        if group%2 == 0 {
            result = append(result, nums[i])
        }
        if (i+1)%2 == 0 {
            group++
        }
    }
    return result
}