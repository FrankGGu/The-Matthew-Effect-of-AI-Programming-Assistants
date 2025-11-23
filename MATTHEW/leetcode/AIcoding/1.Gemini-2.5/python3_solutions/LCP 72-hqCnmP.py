from typing import List

class Solution:
    def supplyWagon(self, capacity: int, items: List[List[int]]) -> int:
        dp = [0] * (capacity + 1)

        for weight, value in items:
            for j in range(capacity, weight - 1, -1):
                dp[j] = max(dp[j], dp[j - weight] + value)

        return dp[capacity]