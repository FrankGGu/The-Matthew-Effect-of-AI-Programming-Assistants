func maximizeSum(nums []int, k int) int {
    sort.Sort(sort.Reverse(sort.IntSlice(nums)))
    sum := 0
    for i := 0; i < k; i++ {
        sum += nums[i] + i
    }
    return sum
}