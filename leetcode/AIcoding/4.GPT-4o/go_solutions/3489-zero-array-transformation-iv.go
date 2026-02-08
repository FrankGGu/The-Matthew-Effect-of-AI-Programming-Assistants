func zeroArrayTransformation(nums []int, operations [][]int) []int {
    for _, op := range operations {
        a, b := op[0], op[1]
        for i := a; i <= b; i++ {
            nums[i] = 0
        }
    }
    return nums
}