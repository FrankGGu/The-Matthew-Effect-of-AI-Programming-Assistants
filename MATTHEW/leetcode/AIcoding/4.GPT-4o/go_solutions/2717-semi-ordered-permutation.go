func semiOrderedPermutation(nums []int) int {
    n := len(nums)
    left, right := 0, 0

    for left < n && nums[left] == left+1 {
        left++
    }

    for right < n && nums[n-right-1] == n-right {
        right++
    }

    if left + right == n {
        return 0
    }

    return (left > 0 ? 1 : 0) + (n - left - right - 1) + (right > 0 ? 1 : 0)
}