func longestSubarray(nums []int, limit int) int {
    minDeque := make([]int, 0)
    maxDeque := make([]int, 0)
    left := 0
    maxLength := 0

    for right := 0; right < len(nums); right++ {
        for len(minDeque) > 0 && nums[minDeque[len(minDeque)-1]] >= nums[right] {
            minDeque = minDeque[:len(minDeque)-1]
        }
        minDeque = append(minDeque, right)

        for len(maxDeque) > 0 && nums[maxDeque[len(maxDeque)-1]] <= nums[right] {
            maxDeque = maxDeque[:len(maxDeque)-1]
        }
        maxDeque = append(maxDeque, right)

        for nums[maxDeque[0]]-nums[minDeque[0]] > limit {
            left++
            if minDeque[0] < left {
                minDeque = minDeque[1:]
            }
            if maxDeque[0] < left {
                maxDeque = maxDeque[1:]
            }
        }

        maxLength = max(maxLength, right-left+1)
    }
    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}