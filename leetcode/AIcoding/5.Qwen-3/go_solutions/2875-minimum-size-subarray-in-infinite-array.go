package main

func minSubarray(nums []int, k int) int {
    n := len(nums)
    if k == 0 {
        return 0
    }
    modMap := make(map[int]int)
    modMap[0] = -1
    currentSum := 0
    minLength := n + 1
    for i := 0; i < n; i++ {
        currentSum += nums[i]
        mod := currentSum % k
        if mod < 0 {
            mod += k
        }
        if prev, ok := modMap[mod]; ok {
            minLength = min(minLength, i-prev)
        }
        modMap[mod] = i
    }
    if minLength <= n {
        return minLength
    }
    return -1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}