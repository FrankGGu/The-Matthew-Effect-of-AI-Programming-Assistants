class Solution:
    def canMakeSquare(self, grid: List[List[str]]) -> bool:
        for i in range(2):
            for j in range(2):
                count = {}
                count[grid[i][j]] = count.get(grid[i][j], 0) + 1
                count[grid[i][j+1]] = count.get(grid[i][j+1], 0) + 1
                count[grid[i+1][j]] = count.get(grid[i+1][j], 0) + 1
                count[grid[i+1][j+1]] = count.get(grid[i+1][j+1], 0) + 1
                if count.get('B', 0) >= 3 or count.get('W', 0) >= 3:
                    return True
        return False