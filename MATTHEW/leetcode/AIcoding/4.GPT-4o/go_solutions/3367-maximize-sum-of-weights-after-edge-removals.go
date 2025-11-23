func maximizeSum(nums []int, removeCount int) int {
    sort.Sort(sort.Reverse(sort.IntSlice(nums)))
    total := 0
    for i := 0; i < len(nums); i++ {
        if removeCount > 0 {
            removeCount--
        } else {
            total += nums[i]
        }
    }
    return total
}