func alternatingSubarray(nums []int) int {
    maxLen := -1
    n := len(nums)

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if nums[j] - nums[j-1] == 1 && (j - i) % 2 == 1 {
                if j - i + 1 > maxLen {
                    maxLen = j - i + 1
                }
            } else if nums[j] - nums[j-1] == -1 && (j - i) % 2 == 0 {
                if j - i + 1 > maxLen {
                    maxLen = j - i + 1
                }
            } else {
                break
            }
        }
    }

    return maxLen
}