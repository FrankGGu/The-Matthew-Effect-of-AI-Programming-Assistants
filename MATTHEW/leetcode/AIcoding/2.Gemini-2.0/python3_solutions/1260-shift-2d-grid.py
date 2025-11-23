class Solution:
    def shiftGrid(self, grid: List[List[int]], k: int) -> List[List[int]]:
        m, n = len(grid), len(grid[0])
        k = k % (m * n)

        temp = []
        for row in grid:
            temp.extend(row)

        temp = temp[-k:] + temp[:-k]

        result = []
        for i in range(m):
            result.append(temp[i*n:(i+1)*n])

        return result