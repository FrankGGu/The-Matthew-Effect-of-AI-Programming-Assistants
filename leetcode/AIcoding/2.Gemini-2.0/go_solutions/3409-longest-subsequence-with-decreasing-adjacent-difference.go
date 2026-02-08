func longestSubsequence(arr []int, difference int) int {
    dp := make(map[int]int)
    ans := 0
    for _, num := range arr {
        dp[num] = dp[num-difference] + 1
        if dp[num] > ans {
            ans = dp[num]
        }
    }
    return ans
}