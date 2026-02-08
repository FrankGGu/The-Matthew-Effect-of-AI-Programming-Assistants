class Solution:
    def frogJumpII(self, stones: list[int]) -> int:
        n = len(stones)
        if n == 2:
            return stones[1] - stones[0]

        max_adjacent_diff = 0
        for i in range(n - 1):
            max_adjacent_diff = max(max_adjacent_diff, stones[i+1] - stones[i])

        return max_adjacent_diff