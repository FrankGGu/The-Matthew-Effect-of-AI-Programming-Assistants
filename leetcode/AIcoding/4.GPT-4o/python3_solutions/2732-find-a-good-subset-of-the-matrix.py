class Solution:
    def goodSubsetofMatrix(self, grid: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict

        n, m = len(grid), len(grid[0])
        value_positions = defaultdict(list)

        for i in range(n):
            for j in range(m):
                value_positions[grid[i][j]].append((i, j))

        for value, positions in value_positions.items():
            if len(positions) >= 2:
                return [list(positions[0]), list(positions[1])]

        return []