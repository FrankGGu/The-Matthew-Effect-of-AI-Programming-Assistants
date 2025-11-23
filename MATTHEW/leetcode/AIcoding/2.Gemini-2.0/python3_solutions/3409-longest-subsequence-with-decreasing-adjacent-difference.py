def longestSubsequence(arr: list[int], difference: int) -> int:
    dp = {}
    ans = 0
    for num in arr:
        if num - difference in dp:
            dp[num] = dp[num - difference] + 1
        else:
            dp[num] = 1
        ans = max(ans, dp[num])
    return ans