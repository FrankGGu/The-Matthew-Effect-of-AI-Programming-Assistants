class Solution:
    def maxJump(self, stones: List[int]) -> int:
        n = len(stones)
        if n == 2:
            return stones[1] - stones[0]
        max_cost = 0
        for i in range(2, n):
            max_cost = max(max_cost, stones[i] - stones[i-2])
        return max_cost