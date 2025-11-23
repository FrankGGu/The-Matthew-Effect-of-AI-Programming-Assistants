func subsets(nums []int) [][]int {
    result := [][]int{}
    n := len(nums)
    for i := 0; i < (1 << n); i++ {
        subset := []int{}
        for j := 0; j < n; j++ {
            if i&(1<<j) != 0 {
                subset = append(subset, nums[j])
            }
        }
        result = append(result, subset)
    }
    return result
}