class Solution:
    def gridGame(self, grid: List[List[int]]) -> int:
        n = len(grid[0])
        prefix_sum_top = [0] * (n + 1)
        prefix_sum_bottom = [0] * (n + 1)

        for i in range(n):
            prefix_sum_top[i + 1] = prefix_sum_top[i] + grid[0][i]
            prefix_sum_bottom[i + 1] = prefix_sum_bottom[i] + grid[1][i]

        ans = float('inf')
        for i in range(n):
            top = prefix_sum_top[n] - prefix_sum_top[i + 1]
            bottom = prefix_sum_bottom[i]
            ans = min(ans, max(top, bottom))

        return ans