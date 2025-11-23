class Solution:
    def lengthOfLongestSubsequence(self, nums: List[int], target: int) -> int:
        dp = {0: 0}
        for num in nums:
            new_dp = dp.copy()
            for s in dp:
                if s + num <= target:
                    new_dp[s + num] = max(new_dp.get(s + num, 0), dp[s] + 1)
            dp = new_dp
        return dp.get(target, 0)