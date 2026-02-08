func countPairs(nums []int, target int) int {
    sort.Ints(nums)
    count := 0
    left, right := 0, len(nums)-1

    for left < right {
        if nums[left]+nums[right] < target {
            count += right - left
            left++
        } else {
            right--
        }
    }

    return count
}