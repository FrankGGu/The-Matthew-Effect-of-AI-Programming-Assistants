class Solution:
    def minIncrements(self, n: int, cost: list[int]) -> int:
        ans = 0
        for i in range(n // 2 - 1, -1, -1):
            ans += abs(cost[2 * i + 1] - cost[2 * i + 2])
            cost[i] += max(cost[2 * i + 1], cost[2 * i + 2])
        return ans