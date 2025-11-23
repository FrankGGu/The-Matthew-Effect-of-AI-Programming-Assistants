func maxSumOfKElements(nums []int, k int) int {
    sort.Ints(nums)
    sum := 0
    for i := len(nums) - k; i < len(nums); i++ {
        sum += nums[i]
    }
    return sum
}