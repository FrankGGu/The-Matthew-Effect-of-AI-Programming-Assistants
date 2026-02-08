func minOperations(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    operations := 0
    for _, num := range nums {
        operations += maxNum - num
    }

    return operations
}