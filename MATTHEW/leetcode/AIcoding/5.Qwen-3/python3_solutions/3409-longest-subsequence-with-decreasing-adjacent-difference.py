class Solution:
    def longestSubsequence(self, nums: List[int], minDiff: int) -> int:
        from collections import defaultdict

        dp = defaultdict(int)
        for num in nums:
            max_len = 0
            for key in dp:
                if abs(num - key) >= minDiff:
                    max_len = max(max_len, dp[key])
            dp[num] = max_len + 1
        return max(dp.values())