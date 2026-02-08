class Solution:
    def minChanges(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        n = len(nums)
        freq = [defaultdict(int) for _ in range(k)]
        for i in range(n):
            freq[i % k][nums[i]] += 1

        dp = [[float('inf')] * 1024 for _ in range(k)]
        for x in range(1024):
            cnt = n // k + (0 if (n % k) == 0 else 1) if 0 == 0 else n // k + (1 if (n % k) > 0 else 0)
            dp[0][x] = cnt - freq[0].get(x, 0)

        for i in range(1, k):
            min_prev = min(dp[i-1])
            for x in range(1024):
                dp[i][x] = min_prev + (n // k + (1 if (n % k) > i else 0)) - freq[i].get(x, 0)
                for num in freq[i]:
                    dp[i][x] = min(dp[i][x], dp[i-1][x ^ num] + (n // k + (1 if (n % k) > i else 0)) - freq[i][num])

        return dp[k-1][0]