func longestSubarray(nums []int) int {
    maxAnd := 0
    for _, num := range nums {
        if num > maxAnd {
            maxAnd = num
        }
    }

    maxLen := 0
    current := 0
    for _, num := range nums {
        if num == maxAnd {
            current++
            if current > maxLen {
                maxLen = current
            }
        } else {
            current = 0
        }
    }
    return maxLen
}