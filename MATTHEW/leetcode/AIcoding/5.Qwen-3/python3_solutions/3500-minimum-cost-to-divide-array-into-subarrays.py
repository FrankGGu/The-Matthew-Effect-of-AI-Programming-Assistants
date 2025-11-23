class Solution:
    def minCost(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0
        for i in range(1, n + 1):
            freq = defaultdict(int)
            max_freq = 0
            cost = 0
            for j in range(i - 1, -1, -1):
                freq[nums[j]] += 1
                max_freq = max(max_freq, freq[nums[j]])
                cost = max(freq.values()) * (i - j)
                if j - 1 >= 0:
                    dp[i] = min(dp[i], dp[j] + cost)
                else:
                    dp[i] = min(dp[i], cost)
        return dp[n]