class Solution:
    def countAsterisks(self, grid: List[List[str]]) -> int:
        count = 0
        for row in grid:
            for cell in row:
                if cell == '*':
                    count += 1
        return count