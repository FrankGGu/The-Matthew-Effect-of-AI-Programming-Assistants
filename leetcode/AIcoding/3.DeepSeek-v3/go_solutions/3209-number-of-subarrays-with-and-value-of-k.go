func countSubarrays(nums []int, k int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        currentAnd := nums[i]
        if currentAnd == k {
            count++
        }
        for j := i + 1; j < n; j++ {
            currentAnd &= nums[j]
            if currentAnd == k {
                count++
            } else if currentAnd < k {
                break
            }
        }
    }
    return count
}