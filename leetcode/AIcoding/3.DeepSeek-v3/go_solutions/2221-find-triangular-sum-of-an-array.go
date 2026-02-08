func triangularSum(nums []int) int {
    for len(nums) > 1 {
        newNums := make([]int, len(nums)-1)
        for i := 0; i < len(nums)-1; i++ {
            newNums[i] = (nums[i] + nums[i+1]) % 10
        }
        nums = newNums
    }
    return nums[0]
}