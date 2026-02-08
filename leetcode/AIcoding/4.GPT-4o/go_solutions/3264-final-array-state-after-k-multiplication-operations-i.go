func finalArray(nums []int, operations [][]int) []int {
    for _, op := range operations {
        for i := op[0]; i <= op[1]; i++ {
            nums[i] *= op[2]
        }
    }
    return nums
}