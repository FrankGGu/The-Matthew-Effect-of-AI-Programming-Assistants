class Solution:
    def longestSubsequence(self, arr: List[int], target: int) -> int:
        dp = {0: 0}
        for num in arr:
            for t in list(dp.keys())[::-1]:
                if t + num <= target:
                    dp[t + num] = max(dp.get(t + num, 0), dp[t] + 1)
        return max(dp.values())