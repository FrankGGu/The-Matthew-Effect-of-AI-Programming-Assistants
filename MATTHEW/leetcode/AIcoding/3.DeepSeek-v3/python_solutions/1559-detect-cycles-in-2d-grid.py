class Solution:
    def containsCycle(self, grid: List[List[str]]) -> bool:
        rows, cols = len(grid), len(grid[0])
        visited = [[False for _ in range(cols)] for _ in range(rows)]

        for i in range(rows):
            for j in range(cols):
                if not visited[i][j]:
                    if self.dfs(grid, i, j, -1, -1, visited, grid[i][j]):
                        return True
        return False

    def dfs(self, grid, i, j, pi, pj, visited, char):
        rows, cols = len(grid), len(grid[0])
        if i < 0 or i >= rows or j < 0 or j >= cols or grid[i][j] != char:
            return False

        if visited[i][j]:
            return True

        visited[i][j] = True

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        for di, dj in directions:
            ni, nj = i + di, j + dj
            if (ni, nj) != (pi, pj):
                if self.dfs(grid, ni, nj, i, j, visited, char):
                    return True
        return False