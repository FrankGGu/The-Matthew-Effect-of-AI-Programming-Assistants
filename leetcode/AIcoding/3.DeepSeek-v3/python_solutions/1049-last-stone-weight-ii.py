class Solution:
    def lastStoneWeightII(self, stones: List[int]) -> int:
        total = sum(stones)
        target = total // 2
        dp = [False] * (target + 1)
        dp[0] = True
        for stone in stones:
            for j in range(target, stone - 1, -1):
                dp[j] = dp[j] or dp[j - stone]
        for j in range(target, -1, -1):
            if dp[j]:
                return total - 2 * j
        return 0