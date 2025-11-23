class NeighborSum:

    def __init__(self, grid: List[List[int]]):
        self.grid = grid
        self.m = len(grid)
        self.n = len(grid[0]) if self.m > 0 else 0
        self.prefix_sum = [[0] * (self.n + 1) for _ in range(self.m + 1)]
        for i in range(1, self.m + 1):
            for j in range(1, self.n + 1):
                self.prefix_sum[i][j] = self.prefix_sum[i-1][j] + self.prefix_sum[i][j-1] - self.prefix_sum[i-1][j-1] + grid[i-1][j-1]

    def get_sum(self, row1: int, col1: int, row2: int, col2: int) -> int:
        row1 += 1
        col1 += 1
        row2 += 1
        col2 += 1
        return self.prefix_sum[row2][col2] - self.prefix_sum[row1-1][col2] - self.prefix_sum[row2][col1-1] + self.prefix_sum[row1-1][col1-1]

    def get_neighbor_sum(self, row: int, col: int, k: int) -> int:
        row1 = max(0, row - k)
        col1 = max(0, col - k)
        row2 = min(self.m - 1, row + k)
        col2 = min(self.n - 1, col + k)
        return self.get_sum(row1, col1, row2, col2)