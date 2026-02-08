func longestSubarray(nums []int, limit int) int {
    maxQueue := []int{}
    minQueue := []int{}
    left := 0
    ans := 0
    for right, num := range nums {
        for len(maxQueue) > 0 && nums[maxQueue[len(maxQueue)-1]] <= num {
            maxQueue = maxQueue[:len(maxQueue)-1]
        }
        maxQueue = append(maxQueue, right)

        for len(minQueue) > 0 && nums[minQueue[len(minQueue)-1]] >= num {
            minQueue = minQueue[:len(minQueue)-1]
        }
        minQueue = append(minQueue, right)

        for nums[maxQueue[0]]-nums[minQueue[0]] > limit {
            if maxQueue[0] == left {
                maxQueue = maxQueue[1:]
            }
            if minQueue[0] == left {
                minQueue = minQueue[1:]
            }
            left++
        }

        ans = max(ans, right-left+1)
    }
    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}