func sortArrayByParity(nums []int) []int {
    left := 0
    right := len(nums) - 1

    for left < right {
        if nums[left]%2 == 0 { // nums[left] is even, it's in the correct place
            left++
        } else if nums[right]%2 != 0 { // nums[right] is odd, it's in the correct place
            right--
        } else { // nums[left] is odd and nums[right] is even, swap them
            nums[left], nums[right] = nums[right], nums[left]
            left++
            right--
        }
    }
    return nums
}