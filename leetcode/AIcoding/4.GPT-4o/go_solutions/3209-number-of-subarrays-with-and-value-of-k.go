func countSubarrays(nums []int, k int) int {
    n := len(nums)
    count := 0

    for i := 0; i < n; i++ {
        andValue := nums[i]
        if andValue == k {
            count++
        }
        for j := i + 1; j < n; j++ {
            andValue &= nums[j]
            if andValue == k {
                count++
            } else if andValue < k {
                break
            }
        }
    }

    return count
}