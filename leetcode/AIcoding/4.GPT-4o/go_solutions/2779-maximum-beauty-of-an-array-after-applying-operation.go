func maximumBeauty(nums []int, k int) int {
    n := len(nums)
    sort.Ints(nums)
    maxBeauty := 0
    left := 0

    for right := 0; right < n; right++ {
        for left < n && nums[right]-nums[left] > 2*k {
            left++
        }
        maxBeauty = max(maxBeauty, right-left+1)
    }

    return maxBeauty
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}