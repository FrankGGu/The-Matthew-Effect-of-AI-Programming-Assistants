def longestSubsequence(arr, difference):
    dp = {}
    longest = 0

    for num in arr:
        dp[num] = dp.get(num - difference, 0) + 1
        longest = max(longest, dp[num])

    return longest