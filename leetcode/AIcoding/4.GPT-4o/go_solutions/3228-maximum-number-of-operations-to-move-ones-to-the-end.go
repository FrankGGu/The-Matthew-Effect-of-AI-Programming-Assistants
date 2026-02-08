func maxOperations(nums []int) int {
    count := 0
    for i, num := range nums {
        if num == 1 {
            count++
            nums = append(nums[:i], nums[i+1:]...)
            i-- // Adjust index after removal
        }
    }
    return count
}