class Solution:
    def longestSubsequence(self, arr: List[int], difference: int) -> int:
        from collections import defaultdict

        dp = defaultdict(int)
        for num in arr:
            dp[num] = dp[num - difference] + 1
        return max(dp.values())