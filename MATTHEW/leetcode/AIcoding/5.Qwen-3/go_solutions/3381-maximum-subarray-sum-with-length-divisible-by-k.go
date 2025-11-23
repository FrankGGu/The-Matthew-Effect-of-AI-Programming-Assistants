package main

func maxSubarraySum(nums []int, k int) int {
    n := len(nums)
    prefixMod := make(map[int]int)
    prefixMod[0] = -1
    maxSum := -1 << 63
    currentSum := 0

    for i := 0; i < n; i++ {
        currentSum += nums[i]
        mod := currentSum % k
        if mod < 0 {
            mod += k
        }
        if val, ok := prefixMod[mod]; ok {
            maxSum = max(maxSum, currentSum - nums[val+1])
        } else {
            prefixMod[mod] = i
        }
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}