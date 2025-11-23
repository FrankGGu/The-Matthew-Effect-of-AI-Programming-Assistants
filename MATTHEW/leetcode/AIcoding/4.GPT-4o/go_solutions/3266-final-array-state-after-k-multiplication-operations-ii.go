func finalArray(nums []int, k int) []int {
    n := len(nums)
    mul := 1
    for i := 0; i < k; i++ {
        mul *= 2
        if mul > 1e9 {
            mul = 1e9
            break
        }
    }
    for i := 0; i < n; i++ {
        nums[i] *= mul
        if nums[i] > 1e9 {
            nums[i] = 1e9
        }
    }
    return nums
}