class Solution:
    def surfaceArea(self, grid: list[list[int]]) -> int:
        N = len(grid)
        M = len(grid[0])
        total_area = 0

        for i in range(N):
            for j in range(M):
                h = grid[i][j]

                if h == 0:
                    continue

                total_area += 2  # Top and bottom faces

                # North face (towards i-1)
                if i == 0:
                    total_area += h
                else:
                    total_area += max(0, h - grid[i-1][j])

                # South face (towards i+1)
                if i == N - 1:
                    total_area += h
                else:
                    total_area += max(0, h - grid[i+1][j])

                # West face (towards j-1)
                if j == 0:
                    total_area += h
                else:
                    total_area += max(0, h - grid[i][j-1])

                # East face (towards j+1)
                if j == M - 1:
                    total_area += h
                else:
                    total_area += max(0, h - grid[i][j+1])

        return total_area