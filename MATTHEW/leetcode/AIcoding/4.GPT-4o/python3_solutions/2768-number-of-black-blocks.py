class Solution:
    def countBlackBlocks(self, m: int, n: int, coordinates: List[List[int]]) -> List[int]:
        grid = [[0] * (n + 1) for _ in range(m + 1)]
        for x, y in coordinates:
            grid[x][y] = 1

        def in_bounds(x, y):
            return 0 <= x < m and 0 <= y < n

        result = [0] * 5
        directions = [(0, 0), (0, 1), (1, 0), (1, 1), (1, 1)]

        for x, y in coordinates:
            for dx in range(2):
                for dy in range(2):
                    nx, ny = x + dx, y + dy
                    if in_bounds(nx, ny):
                        count = 0
                        for ddx in range(2):
                            for ddy in range(2):
                                if in_bounds(nx + ddx, ny + ddy) and grid[nx + ddx][ny + ddy]:
                                    count += 1
                        if count > 0:
                            result[count] += 1

        return result[1:5]