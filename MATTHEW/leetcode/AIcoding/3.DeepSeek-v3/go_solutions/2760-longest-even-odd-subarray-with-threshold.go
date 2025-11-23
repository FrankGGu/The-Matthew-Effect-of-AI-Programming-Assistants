func longestAlternatingSubarray(nums []int, threshold int) int {
    maxLen := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        if nums[i]%2 != 0 || nums[i] > threshold {
            continue
        }
        currentLen := 1
        for j := i + 1; j < n; j++ {
            if nums[j] > threshold || nums[j]%2 == nums[j-1]%2 {
                break
            }
            currentLen++
        }
        if currentLen > maxLen {
            maxLen = currentLen
        }
    }
    return maxLen
}