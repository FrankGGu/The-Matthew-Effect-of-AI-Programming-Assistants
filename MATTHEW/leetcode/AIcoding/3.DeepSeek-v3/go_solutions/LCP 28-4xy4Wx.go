func purchasePlans(nums []int, target int) int {
    sort.Ints(nums)
    res := 0
    left, right := 0, len(nums)-1
    for left < right {
        if nums[left]+nums[right] > target {
            right--
        } else {
            res += right - left
            left++
        }
        res %= 1000000007
    }
    return res % 1000000007
}