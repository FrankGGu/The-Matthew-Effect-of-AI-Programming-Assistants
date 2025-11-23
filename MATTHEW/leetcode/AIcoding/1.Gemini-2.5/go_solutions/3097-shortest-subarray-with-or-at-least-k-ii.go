func minimumSubarrayLength(nums []int, k int) int {
    n := len(nums)
    minLen := n + 1

    for i := 0; i < n; i++ {
        currentOR := 0
        for j := i; j < n; j++ {
            currentOR |= nums[j]
            if currentOR >= k {
                if j - i + 1 < minLen {
                    minLen = j - i + 1
                }
                break
            }
        }
    }

    if minLen == n + 1 {
        return -1
    }
    return minLen
}