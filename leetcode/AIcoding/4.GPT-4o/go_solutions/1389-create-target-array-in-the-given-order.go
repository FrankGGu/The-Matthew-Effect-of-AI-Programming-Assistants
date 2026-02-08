func createTargetArray(nums []int, index []int) []int {
    target := []int{}
    for i := 0; i < len(nums); i++ {
        target = append(target[:index[i]], append([]int{nums[i]}, target[index[i]:]...)...)
    }
    return target
}