func reductionOperations(nums []int) int {
    sort.Ints(nums)
    operations := 0
    for i := 1; i < len(nums); i++ {
        operations += i
    }
    return operations
}