class Solution:
    def countArtifacts(self, n: int, artifacts: List[List[int]], commands: List[List[int]]) -> int:
        grid = [[0] * n for _ in range(n)]
        for x1, y1, x2, y2 in artifacts:
            for i in range(x1, x2 + 1):
                for j in range(y1, y2 + 1):
                    grid[i][j] += 1
        count = 0
        for x, y in commands:
            if grid[x][y] > 0:
                count += 1
        return count