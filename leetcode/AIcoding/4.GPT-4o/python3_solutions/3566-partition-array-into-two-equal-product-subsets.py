class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        total_product = 1
        for num in nums:
            total_product *= num
        if total_product % 2 != 0:
            return False

        target = total_product // 2
        n = len(nums)
        dp = [False] * (target + 1)
        dp[0] = True

        for num in nums:
            for j in range(target, num - 1, -1):
                dp[j] = dp[j] or dp[j - num]

        return dp[target]