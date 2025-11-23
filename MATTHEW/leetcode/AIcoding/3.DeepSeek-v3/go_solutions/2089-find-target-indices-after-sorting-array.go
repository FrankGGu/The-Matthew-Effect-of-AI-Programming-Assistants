func targetIndices(nums []int, target int) []int {
    sort.Ints(nums)
    res := []int{}
    for i, num := range nums {
        if num == target {
            res = append(res, i)
        }
    }
    return res
}