func separateSquares(nums []int) []int {
    n := len(nums)
    left := 0
    right := n - 1
    result := make([]int, n)

    for left <= right {
        if nums[left] * nums[left] < nums[right] * nums[right] {
            result[right] = nums[right] * nums[right]
            right--
        } else {
            result[right] = nums[left] * nums[left]
            left++
        }
    }

    return result
}