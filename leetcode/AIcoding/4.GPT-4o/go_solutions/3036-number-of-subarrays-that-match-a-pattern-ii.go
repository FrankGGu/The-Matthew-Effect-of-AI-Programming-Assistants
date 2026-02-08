func countSubarrays(nums []int, minK int, maxK int) int {
    left, right, result, countMin, countMax := 0, 0, 0, 0, 0
    for right < len(nums) {
        if nums[right] < minK || nums[right] > maxK {
            left = right + 1
            countMin, countMax = 0, 0
        }
        if nums[right] == minK {
            countMin++
        }
        if nums[right] == maxK {
            countMax++
        }
        result += max(0, min(countMin, countMax))
        right++
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}