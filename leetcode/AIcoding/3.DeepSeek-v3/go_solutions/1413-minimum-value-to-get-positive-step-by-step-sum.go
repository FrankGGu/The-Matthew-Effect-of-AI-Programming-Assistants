func minStartValue(nums []int) int {
    minSum := 0
    sum := 0
    for _, num := range nums {
        sum += num
        if sum < minSum {
            minSum = sum
        }
    }
    return 1 - minSum
}