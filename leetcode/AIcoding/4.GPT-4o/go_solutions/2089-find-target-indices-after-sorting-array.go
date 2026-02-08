func targetIndices(nums []int, target int) []int {
    sort.Ints(nums)
    var indices []int
    for i, num := range nums {
        if num == target {
            indices = append(indices, i)
        }
    }
    return indices
}