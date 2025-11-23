class Solution:
    def minCost(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            freq = {}
            trimmed = 0
            for j in range(i - 1, -1, -1):
                num = nums[j]
                if num in freq:
                    if freq[num] == 1:
                        trimmed += 2
                    else:
                        trimmed += 1
                    freq[num] += 1
                else:
                    freq[num] = 1
                current_cost = k + trimmed
                if dp[j] + current_cost < dp[i]:
                    dp[i] = dp[j] + current_cost

        return dp[n]