class Solution:
    def minimumOperationsToWriteY(self, grid: list[list[int]]) -> int:
        n = len(grid)
        center_row = n // 2
        center_col = n // 2

        y_counts = [0, 0, 0]
        non_y_counts = [0, 0, 0]

        for r in range(n):
            for c in range(n):
                is_y_cell = False
                if r <= center_row:
                    if r == c or r + c == n - 1:
                        is_y_cell = True
                else:
                    if c == center_col:
                        is_y_cell = True

                if is_y_cell:
                    y_counts[grid[r][c]] += 1
                else:
                    non_y_counts[grid[r][c]] += 1

        total_y_cells = sum(y_counts)
        total_non_y_cells = sum(non_y_counts)

        min_operations = float('inf')

        for val_y in range(3):
            for val_non_y in range(3):
                if val_y == val_non_y:
                    continue

                ops_for_y = total_y_cells - y_counts[val_y]
                ops_for_non_y = total_non_y_cells - non_y_counts[val_non_y]

                min_operations = min(min_operations, ops_for_y + ops_for_non_y)

        return min_operations