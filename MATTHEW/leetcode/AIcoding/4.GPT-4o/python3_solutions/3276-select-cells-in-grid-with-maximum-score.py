class Solution:
    def maximumScore(self, grid: List[List[int]], row: int, col: int) -> int:
        m, n = len(grid), len(grid[0])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        visited = set()

        def dfs(r, c):
            if (r, c) in visited or r < 0 or r >= m or c < 0 or c >= n:
                return 0
            visited.add((r, c))
            score = grid[r][c]
            max_score = score
            for dr, dc in directions:
                max_score = max(max_score, score + dfs(r + dr, c + dc))
            visited.remove((r, c))
            return max_score

        return dfs(row, col)