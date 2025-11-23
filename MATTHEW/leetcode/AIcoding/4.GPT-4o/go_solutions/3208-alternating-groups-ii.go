func alternatingGroups(nums []int) []int {
    n := len(nums)
    result := make([]int, n)
    for i, num := range nums {
        if i%2 == 0 {
            result[i] = num
        } else {
            result[i] = -num
        }
    }
    return result
}