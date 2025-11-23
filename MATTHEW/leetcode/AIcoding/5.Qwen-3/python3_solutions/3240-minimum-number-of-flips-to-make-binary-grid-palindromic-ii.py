class Solution:
    def minFlipsToMakePalindrome(self, grid: List[List[str]]) -> int:
        n = len(grid)
        m = len(grid[0])
        flips = 0
        for i in range(n):
            for j in range(m // 2):
                if grid[i][j] != grid[i][m - 1 - j]:
                    flips += 1
        return flips