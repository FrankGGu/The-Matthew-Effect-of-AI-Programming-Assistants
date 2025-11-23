class Solution:
    def solve(self, n: int, m: int) -> int:
        total_cells = n * m
        black_cells = (total_cells + 1) // 2
        return black_cells