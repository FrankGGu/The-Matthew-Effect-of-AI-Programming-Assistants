class Solution:
    def gridGame(self, grid: List[List[int]]) -> int:
        n = len(grid)
        top = grid[0]
        bottom = grid[1]
        for i in range(1, n):
            top[i] += top[i - 1]
            bottom[i] += bottom[i - 1]
        res = float('inf')
        for i in range(n):
            upper = top[n - 1] - top[i]
            lower = bottom[i - 1] if i > 0 else 0
            res = min(res, max(upper, lower))
        return res