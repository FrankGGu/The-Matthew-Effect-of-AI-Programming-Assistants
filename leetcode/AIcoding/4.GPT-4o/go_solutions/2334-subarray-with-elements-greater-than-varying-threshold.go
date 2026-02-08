func countSubarrays(nums []int, minK int, maxK int) int {
    count := 0
    left := 0
    validStart := -1

    for right := 0; right < len(nums); right++ {
        if nums[right] < minK || nums[right] > maxK {
            left = right + 1
            validStart = -1
        }
        if nums[right] >= minK && nums[right] <= maxK {
            if validStart == -1 {
                validStart = right
            }
            count += validStart - left + 1
        }
    }
    return count
}