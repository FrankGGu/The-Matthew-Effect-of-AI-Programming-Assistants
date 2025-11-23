class Solution:
    def gridGame(self, grid: List[List[int]]) -> int:
        n = len(grid[0])
        prefix_top = [0] * (n + 1)
        prefix_bottom = [0] * (n + 1)

        for i in range(n-1, -1, -1):
            prefix_top[i] = prefix_top[i+1] + grid[0][i]

        for i in range(n):
            prefix_bottom[i+1] = prefix_bottom[i] + grid[1][i]

        res = float('inf')
        for i in range(n):
            res = min(res, max(prefix_top[i+1], prefix_bottom[i]))

        return res