class Solution:
    def largestLocal(self, grid: list[list[int]]) -> list[list[int]]:
        n = len(grid)
        result_n = n - 2

        max_local = [[0] * result_n for _ in range(result_n)]

        for i in range(result_n):
            for j in range(result_n):
                current_max_val = 0
                for r_offset in range(3):
                    for c_offset in range(3):
                        current_max_val = max(current_max_val, grid[i + r_offset][j + c_offset])
                max_local[i][j] = current_max_val

        return max_local