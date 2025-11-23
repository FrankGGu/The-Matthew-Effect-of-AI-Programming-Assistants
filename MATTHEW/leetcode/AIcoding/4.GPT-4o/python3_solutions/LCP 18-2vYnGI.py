class Solution:
    def numCombinations(self, count: List[int], amount: int) -> int:
        dp = [0] * (amount + 1)
        dp[0] = 1

        for c in count:
            for i in range(c, amount + 1):
                dp[i] += dp[i - c]

        return dp[amount]