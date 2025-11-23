class Solution:
    def traverseZigzagWithSkip(self, grid: List[List[int]]) -> List[int]:
        if not grid or not grid[0]:
            return []

        m, n = len(grid), len(grid[0])
        result = []
        for i in range(m):
            if i % 2 == 0:
                for j in range(n):
                    if grid[i][j] != -1:
                        result.append(grid[i][j])
            else:
                for j in range(n-1, -1, -1):
                    if grid[i][j] != -1:
                        result.append(grid[i][j])
        return result