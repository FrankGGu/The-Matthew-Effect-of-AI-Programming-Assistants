class Solution:
    def minimumOperationsToWriteY(self, grid: list[list[str]]) -> int
        from collections import defaultdict

        rows = len(grid)
        cols = len(grid[0])
        y_positions = set()
        center = (rows // 2, cols // 2)

        for i in range(rows):
            for j in range(cols):
                if (i <= rows // 2 and abs(i - j) == abs(i + j - cols + 1)) or (i > rows // 2 and j == cols // 2):
                    y_positions.add((i, j))

        count = defaultdict(int)
        for i in range(rows):
            for j in range(cols):
                count[grid[i][j]] += 1

        y_count = defaultdict(int)
        for i, j in y_positions:
            y_count[grid[i][j]] += 1

        total = 0
        for key in count:
            if key in y_count:
                total += count[key] - y_count[key]
            else:
                total += count[key]

        return total