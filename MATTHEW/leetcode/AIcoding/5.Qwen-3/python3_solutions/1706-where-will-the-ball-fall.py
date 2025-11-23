class Solution:
    def findBall(self, grid: List[List[int]]) -> List[int]:
        m = len(grid)
        n = len(grid[0])
        result = [i for i in range(n)]

        for row in grid:
            new_result = [-1] * n
            for i in range(n):
                if result[i] == -1:
                    continue
                col = result[i]
                if row[col] == 1:
                    if col + 1 < n and row[col + 1] == 1:
                        new_result[i] = col + 1
                else:
                    if col - 1 >= 0 and row[col - 1] == -1:
                        new_result[i] = col - 1
            result = new_result

        return result