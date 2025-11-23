func minMoves(nums []int) int {
    min := nums[0]
    sum := 0
    for _, num := range nums {
        if num < min {
            min = num
        }
        sum += num
    }
    return sum - min * len(nums)
}