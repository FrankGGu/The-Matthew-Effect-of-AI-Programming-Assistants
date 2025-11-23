func minOperations(nums []int) int {
    operations := 0
    for _, num := range nums {
        remainder := num % 3
        if remainder == 1 || remainder == 2 {
            operations++
        }
    }
    return operations
}