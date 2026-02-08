func longestSubarray(nums []int, limit int) int {
    left, right := 0, 0
    minDeque, maxDeque := []int{}, []int{}
    maxLength := 0

    for right < len(nums) {
        for len(maxDeque) > 0 && nums[maxDeque[len(maxDeque)-1]] <= nums[right] {
            maxDeque = maxDeque[:len(maxDeque)-1]
        }
        maxDeque = append(maxDeque, right)

        for len(minDeque) > 0 && nums[minDeque[len(minDeque)-1]] >= nums[right] {
            minDeque = minDeque[:len(minDeque)-1]
        }
        minDeque = append(minDeque, right)

        for nums[maxDeque[0]] - nums[minDeque[0]] > limit {
            left++
            if maxDeque[0] < left {
                maxDeque = maxDeque[1:]
            }
            if minDeque[0] < left {
                minDeque = minDeque[1:]
            }
        }

        maxLength = max(maxLength, right - left + 1)
        right++
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}