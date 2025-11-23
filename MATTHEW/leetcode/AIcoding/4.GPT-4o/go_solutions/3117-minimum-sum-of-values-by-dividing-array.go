func minimumSum(nums []int) int {
    sort.Ints(nums)
    return nums[0] + nums[1] + nums[2] + nums[3]
}