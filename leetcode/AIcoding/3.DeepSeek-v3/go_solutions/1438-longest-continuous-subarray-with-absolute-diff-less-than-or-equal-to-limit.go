func longestSubarray(nums []int, limit int) int {
    minDeque := make([]int, 0)
    maxDeque := make([]int, 0)
    left := 0
    maxLen := 0

    for right := 0; right < len(nums); right++ {
        for len(minDeque) > 0 && nums[right] < nums[minDeque[len(minDeque)-1]] {
            minDeque = minDeque[:len(minDeque)-1]
        }
        minDeque = append(minDeque, right)

        for len(maxDeque) > 0 && nums[right] > nums[maxDeque[len(maxDeque)-1]] {
            maxDeque = maxDeque[:len(maxDeque)-1]
        }
        maxDeque = append(maxDeque, right)

        for nums[maxDeque[0]] - nums[minDeque[0]] > limit {
            if maxDeque[0] == left {
                maxDeque = maxDeque[1:]
            }
            if minDeque[0] == left {
                minDeque = minDeque[1:]
            }
            left++
        }

        if right - left + 1 > maxLen {
            maxLen = right - left + 1
        }
    }

    return maxLen
}