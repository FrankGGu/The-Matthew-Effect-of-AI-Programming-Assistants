package main


func numFactoredBinaryTrees(n int) int {
    nums := make([]int, 0)
    m := make(map[int]int)
    for i := 1; i <= n; i++ {
        nums = append(nums, i)
        m[i] = len(nums) - 1
    }
    sort.Ints(nums)
    dp := make([]int, n+1)
    for i := 0; i < len(nums); i++ {
        dp[nums[i]] = 1
        for j := 0; j < i; j++ {
            if nums[i]%nums[j] == 0 {
                k := nums[i] / nums[j]
                if idx, ok := m[k]; ok {
                    dp[nums[i]] += dp[nums[j]] * dp[nums[idx]]
                }
            }
        }
    }
    total := 0
    for i := 1; i <= n; i++ {
        total += dp[i]
    }
    return total
}