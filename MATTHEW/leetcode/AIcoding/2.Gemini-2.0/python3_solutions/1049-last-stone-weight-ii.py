class Solution:
    def lastStoneWeightII(self, stones: list[int]) -> int:
        total_sum = sum(stones)
        target = total_sum // 2
        n = len(stones)
        dp = [False] * (target + 1)
        dp[0] = True

        for stone in stones:
            for i in range(target, stone - 1, -1):
                dp[i] = dp[i] or dp[i - stone]

        for i in range(target, -1, -1):
            if dp[i]:
                return total_sum - 2 * i