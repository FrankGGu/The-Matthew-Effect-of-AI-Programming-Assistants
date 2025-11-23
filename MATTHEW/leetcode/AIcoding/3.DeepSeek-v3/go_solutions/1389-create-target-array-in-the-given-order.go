func createTargetArray(nums []int, index []int) []int {
    target := make([]int, len(nums))
    for i := 0; i < len(nums); i++ {
        pos := index[i]
        if pos < i {
            copy(target[pos+1:], target[pos:])
        }
        target[pos] = nums[i]
    }
    return target
}