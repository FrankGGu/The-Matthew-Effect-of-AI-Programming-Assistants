class Solution:
    def canPartition(self, nums: list[int]) -> bool:
        total_sum = sum(nums)

        if total_sum % 2 != 0:
            return False

        target = total_sum // 2

        # dp[i] will be true if sum i can be formed by a subset of nums
        dp = [False] * (target + 1)
        dp[0] = True # Sum 0 is always possible (empty subset)

        for num in nums:
            # Iterate backwards to avoid using the same number multiple times in one pass
            # for the current 'num'
            for j in range(target, num - 1, -1):
                dp[j] = dp[j] or dp[j - num]

            # Optimization: if target is already reached, no need to process further numbers
            if dp[target]:
                return True

        return dp[target]