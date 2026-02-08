func largestDivisibleSubset(nums []int) []int {
    if len(nums) == 0 {
        return []int{}
    }
    sort.Ints(nums)
    n := len(nums)
    dp := make([]int, n)
    parent := make([]int, n)
    maxLen, maxIdx := 0, -1

    for i := 0; i < n; i++ {
        dp[i] = 1
        parent[i] = -1
        for j := 0; j < i; j++ {
            if nums[i]%nums[j] == 0 && dp[i] < dp[j]+1 {
                dp[i] = dp[j] + 1
                parent[i] = j
            }
        }
        if dp[i] > maxLen {
            maxLen = dp[i]
            maxIdx = i
        }
    }

    res := []int{}
    for maxIdx != -1 {
        res = append(res, nums[maxIdx])
        maxIdx = parent[maxIdx]
    }
    return res
}