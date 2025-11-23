class Solution:
    def numMovesStonesII(self, stones):
        n = len(stones)
        stones.sort()
        max_gap = max(stones[i + 1] - stones[i] for i in range(n - 1))
        max_gap = max(max_gap, 2 - (stones[0] - 1), (n - stones[-1]))

        if n == 2:
            return [0, 0] if stones[1] - stones[0] == 1 else [1, 1]

        min_moves = float('inf')
        j = 0
        for i in range(n):
            while j < n and stones[j] - stones[i] < n:
                j += 1
            min_moves = min(min_moves, n - (j - i))

        return [min_moves, max_gap]