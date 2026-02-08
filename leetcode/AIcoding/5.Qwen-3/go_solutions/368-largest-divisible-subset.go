package main

func largestDivisibleSubset(nums []int) []int {
    if len(nums) == 0 {
        return []int{}
    }
    sort.Ints(nums)
    n := len(nums)
    dp := make([]int, n)
    parent := make([]int, n)
    maxIndex := 0
    for i := 0; i < n; i++ {
        dp[i] = 1
        parent[i] = -1
        for j := 0; j < i; j++ {
            if nums[i]%nums[j] == 0 {
                if dp[j]+1 > dp[i] {
                    dp[i] = dp[j] + 1
                    parent[i] = j
                }
            }
        }
        if dp[i] > dp[maxIndex] {
            maxIndex = i
        }
    }
    result := make([]int, 0, dp[maxIndex])
    for maxIndex != -1 {
        result = append(result, nums[maxIndex])
        maxIndex = parent[maxIndex]
    }
    for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
        result[i], result[j] = result[j], result[i]
    }
    return result
}