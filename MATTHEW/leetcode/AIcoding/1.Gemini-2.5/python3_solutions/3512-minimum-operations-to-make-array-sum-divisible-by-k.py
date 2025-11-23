import collections

class Solution:
    def minOperations(self, nums: list[int], k: int) -> int:
        total_sum = sum(nums)
        target_remainder = total_sum % k

        if target_remainder == 0:
            return 0

        dp = [float('inf')] * k
        dp[0] = 0

        for num in nums:
            for j in range(k - 1, -1, -1):
                if dp[j] != float('inf'):
                    new_remainder = (j + num) % k
                    dp[new_remainder] = min(dp[new_remainder], dp[j] + 1)

        if dp[target_remainder] == float('inf'):
            return -1
        else:
            return dp[target_remainder]