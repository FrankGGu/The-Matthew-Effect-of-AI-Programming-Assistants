class Solution:
    def minSumOfThreeSubarrays(self, nums: List[int], target: int) -> int:
        import sys

        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        dp = [float('inf')] * (n + 1)
        dp[0] = 0
        prev = [-1] * (n + 1)

        for i in range(1, n + 1):
            for j in range(i):
                if prefix[i] - prefix[j] == target:
                    if dp[j] + (i - j) < dp[i]:
                        dp[i] = dp[j] + (i - j)
                        prev[i] = j

        res = float('inf')
        for i in range(n + 1):
            if dp[i] != float('inf'):
                j = prev[i]
                if j != -1:
                    k = prev[j]
                    if k != -1:
                        res = min(res, dp[i])

        return res