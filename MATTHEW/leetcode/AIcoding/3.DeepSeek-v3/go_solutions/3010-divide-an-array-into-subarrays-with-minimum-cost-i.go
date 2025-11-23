func minimumCost(nums []int) int {
    if len(nums) < 3 {
        return 0
    }
    first := nums[0]
    rest := nums[1:]
    sort.Ints(rest)
    return first + rest[0] + rest[1]
}