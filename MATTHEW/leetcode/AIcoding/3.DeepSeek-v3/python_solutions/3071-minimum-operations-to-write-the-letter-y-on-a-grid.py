class Solution:
    def minimumOperationsToWriteY(self, grid: List[List[int]]) -> int:
        n = len(grid)
        y_cells = set()
        non_y_cells = set()

        for i in range(n):
            for j in range(n):
                if (i == j and i <= n // 2) or (i + j == n - 1 and i <= n // 2) or (j == n // 2 and i > n // 2):
                    y_cells.add((i, j))
                else:
                    non_y_cells.add((i, j))

        y_counts = [0, 0, 0]
        non_y_counts = [0, 0, 0]

        for i, j in y_cells:
            y_counts[grid[i][j]] += 1

        for i, j in non_y_cells:
            non_y_counts[grid[i][j]] += 1

        min_operations = float('inf')

        for y_val in range(3):
            for non_y_val in range(3):
                if y_val == non_y_val:
                    continue
                operations = (sum(y_counts) - y_counts[y_val]) + (sum(non_y_counts) - non_y_counts[non_y_val])
                if operations < min_operations:
                    min_operations = operations

        return min_operations