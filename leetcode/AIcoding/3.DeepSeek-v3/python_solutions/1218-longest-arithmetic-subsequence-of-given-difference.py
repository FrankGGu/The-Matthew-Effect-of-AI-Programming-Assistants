class Solution:
    def longestSubsequence(self, arr: List[int], difference: int) -> int:
        dp = {}
        max_length = 1
        for num in arr:
            prev = num - difference
            if prev in dp:
                dp[num] = dp[prev] + 1
            else:
                dp[num] = 1
            if dp[num] > max_length:
                max_length = dp[num]
        return max_length