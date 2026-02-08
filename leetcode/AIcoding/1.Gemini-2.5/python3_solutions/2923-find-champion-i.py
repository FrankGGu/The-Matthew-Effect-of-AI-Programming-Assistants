class Solution:
    def findChampion(self, grid: list[list[int]]) -> int:
        n = len(grid)
        for i in range(n):
            wins = 0
            for j in range(n):
                if i != j and grid[i][j] == 1:
                    wins += 1
            if wins == n - 1:
                return i
        return -1 # Should not be reached based on problem description (guaranteed champion)