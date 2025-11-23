class Solution:
    def zigzagGridTraversal(self, grid: List[List[int]]) -> List[int]:
        result = []
        m, n = len(grid), len(grid[0])
        for i in range(m):
            if i % 2 == 0:
                for j in range(n):
                    result.append(grid[i][j])
            else:
                for j in range(n-1, -1, -1):
                    result.append(grid[i][j])
        return result