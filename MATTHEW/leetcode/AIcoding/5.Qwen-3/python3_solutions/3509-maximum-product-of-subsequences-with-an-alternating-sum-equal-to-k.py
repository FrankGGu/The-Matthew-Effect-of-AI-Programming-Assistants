class Solution:
    def maxProduct(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        MOD = 10**9 + 7

        n = len(nums)
        dp = [defaultdict(int) for _ in range(n + 1)]
        dp[0][0] = 1

        for i in range(n):
            for j in range(i + 1):
                for s in list(dp[j].keys()):
                    new_s = s + (nums[i] if (j % 2 == 0) else -nums[i])
                    if abs(new_s) <= k * 2:
                        dp[j + 1][new_s] = (dp[j + 1][new_s] + dp[j][s]) % MOD

        result = 0
        for s in dp[n]:
            if s == k:
                for i in range(n):
                    for j in range(i + 1):
                        for t in dp[j]:
                            if t == k:
                                product = 1
                                for m in range(j, n):
                                    product = (product * nums[m]) % MOD
                                result = max(result, product)

        return result