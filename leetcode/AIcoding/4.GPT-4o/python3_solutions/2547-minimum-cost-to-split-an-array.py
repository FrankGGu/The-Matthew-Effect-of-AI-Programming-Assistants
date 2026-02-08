class Solution:
    def minCost(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            unique_elements = set()
            for j in range(i, 0, -1):
                unique_elements.add(nums[j - 1])
                dp[i] = min(dp[i], dp[j - 1] + len(unique_elements) + k - 1)

        return dp[n]