class Solution:
    def longestSubsequence(self, arr: list[int], difference: int) -> int:
        dp = {}
        max_len = 0

        for num in arr:
            current_len = dp.get(num - difference, 0) + 1
            dp[num] = current_len
            max_len = max(max_len, current_len)

        return max_len