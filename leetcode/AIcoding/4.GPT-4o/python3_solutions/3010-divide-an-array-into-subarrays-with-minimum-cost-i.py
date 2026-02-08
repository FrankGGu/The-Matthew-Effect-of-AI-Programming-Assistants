class Solution:
    def minCost(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [0] + [float('inf')] * n
        freq = [0] * 101

        for i in range(1, n + 1):
            freq = [0] * 101
            unique_count = 0
            for j in range(i, 0, -1):
                if freq[nums[j - 1]] == 0:
                    unique_count += 1
                freq[nums[j - 1]] += 1
                dp[i] = min(dp[i], dp[j - 1] + unique_count + k)

        return dp[n] - k