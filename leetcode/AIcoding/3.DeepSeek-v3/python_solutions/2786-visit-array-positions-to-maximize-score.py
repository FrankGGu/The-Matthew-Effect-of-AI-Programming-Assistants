class Solution:
    def maxScore(self, nums: List[int], x: int) -> int:
        n = len(nums)
        dp = [-float('inf')] * 2
        parity = nums[0] % 2
        dp[parity] = nums[0]

        for i in range(1, n):
            current_parity = nums[i] % 2
            same_parity = dp[current_parity] + nums[i]
            diff_parity = dp[1 - current_parity] + nums[i] - x
            max_score = max(same_parity, diff_parity)
            dp[current_parity] = max(dp[current_parity], max_score)

        return max(dp)