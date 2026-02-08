func zerofillArray(nums []int) []int {
    for i, num := range nums {
        if num == 0 {
            nums[i] = 0
        }
    }
    return nums
}