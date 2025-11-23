class Solution:
    def gridGame(self, grid: List[List[int]]) -> int:
        n = len(grid)
        m = len(grid[0])
        top = [0] * m
        bottom = [0] * m
        for i in range(m):
            top[i] = grid[0][i]
            bottom[i] = grid[1][i]
        for i in range(1, m):
            top[i] += top[i - 1]
            bottom[i] += bottom[i - 1]
        res = float('inf')
        for i in range(m):
            upper = top[m - 1] - top[i]
            lower = bottom[i]
            res = min(res, max(upper, lower))
        return res