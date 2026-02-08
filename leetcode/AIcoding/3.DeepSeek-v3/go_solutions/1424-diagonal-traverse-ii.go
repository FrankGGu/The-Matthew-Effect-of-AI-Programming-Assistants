func findDiagonalOrder(nums [][]int) []int {
    groups := make(map[int][]int)
    maxKey := 0

    for i := len(nums) - 1; i >= 0; i-- {
        for j := 0; j < len(nums[i]); j++ {
            key := i + j
            groups[key] = append(groups[key], nums[i][j])
            if key > maxKey {
                maxKey = key
            }
        }
    }

    result := make([]int, 0)
    for i := 0; i <= maxKey; i++ {
        result = append(result, groups[i]...)
    }

    return result
}