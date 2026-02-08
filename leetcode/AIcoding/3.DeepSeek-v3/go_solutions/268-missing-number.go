func missingNumber(nums []int) int {
    n := len(nums)
    total := n * (n + 1) / 2
    sum := 0
    for _, num := range nums {
        sum += num
    }
    return total - sum
}