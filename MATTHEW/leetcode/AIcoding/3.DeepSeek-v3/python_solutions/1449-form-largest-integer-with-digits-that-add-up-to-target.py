class Solution:
    def largestNumber(self, cost: List[int], target: int) -> str:
        dp = [-1] * (target + 1)
        dp[0] = 0
        for t in range(1, target + 1):
            for i in range(9):
                if t >= cost[i] and dp[t - cost[i]] != -1:
                    if dp[t] < dp[t - cost[i]] + 1:
                        dp[t] = dp[t - cost[i]] + 1
        if dp[target] == -1:
            return "0"

        res = []
        remaining = target
        for i in range(8, -1, -1):
            while remaining >= cost[i] and dp[remaining] == dp[remaining - cost[i]] + 1:
                res.append(str(i + 1))
                remaining -= cost[i]
        return ''.join(res)