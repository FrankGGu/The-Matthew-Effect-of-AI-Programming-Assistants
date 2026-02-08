func incremovableSubarrayCount(nums []int) int64 {
    n := len(nums)
    if n == 0 {
        return 0
    }

    left := 0
    for left+1 < n && nums[left] < nums[left+1] {
        left++
    }

    if left == n-1 {
        return int64(n * (n + 1) / 2)
    }

    right := n - 1
    for right-1 >= 0 && nums[right-1] < nums[right] {
        right--
    }

    res := int64(left + 2)
    for i := 0; i <= left; i++ {
        for right < n && nums[i] >= nums[right] {
            right++
        }
        res += int64(n - right + 1)
    }

    return res
}