class Solution:
    def numMagicSquaresInside(self, grid: List[List[int]]) -> int:
        def isMagicSquare(x, y):
            nums = {grid[i][j] for i in range(x, x + 3) for j in range(y, y + 3)}
            if nums != {1, 2, 3, 4, 5, 6, 7, 8, 9}:
                return False
            return (grid[x][y] + grid[x][y + 1] + grid[x][y + 2] == 
                    grid[x + 1][y] + grid[x + 1][y + 1] + grid[x + 1][y + 2] == 
                    grid[x + 2][y] + grid[x + 2][y + 1] + grid[x + 2][y + 2] == 
                    grid[x][y] + grid[x + 1][y] + grid[x + 2][y] == 
                    grid[x][y + 1] + grid[x + 1][y + 1] + grid[x + 2][y + 1] == 
                    grid[x][y + 2] + grid[x + 1][y + 2] + grid[x + 2][y + 2] == 
                    grid[x][y] + grid[x + 1][y + 1] + grid[x + 2][y + 2] == 
                    grid[x + 2][y] + grid[x + 1][y + 1] + grid[x][y + 2] == 15)

        count = 0
        for i in range(len(grid) - 2):
            for j in range(len(grid[0]) - 2):
                if isMagicSquare(i, j):
                    count += 1
        return count