func canMakeSum(nums []int, k int) bool {
    total := 0
    for _, num := range nums {
        total += num
    }
    return total >= k
}