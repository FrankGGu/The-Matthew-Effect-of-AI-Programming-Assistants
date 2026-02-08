func minimumLengthAfterRemovals(nums []int) int {
    sort.Ints(nums)
    left, right := 0, len(nums)-1

    for left < right && nums[left] == nums[left+1] {
        left++
    }

    for left < right && nums[right] == nums[right-1] {
        right--
    }

    return right - left + 1
}