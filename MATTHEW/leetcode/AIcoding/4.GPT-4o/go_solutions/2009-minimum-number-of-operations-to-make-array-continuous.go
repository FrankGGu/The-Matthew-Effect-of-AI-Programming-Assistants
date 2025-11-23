func minOperations(nums []int) int {
    n := len(nums)
    sort.Ints(nums)
    left, maxLength := 0, 0
    for right := 0; right < n; right++ {
        for nums[right]-nums[left] > n-1 {
            left++
        }
        maxLength = max(maxLength, right-left+1)
    }
    return n - maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}