class Solution:
    def oddCells(self, m: int, n: int, indices: List[List[int]]) -> int:
        matrix = [[0 for _ in range(n)] for _ in range(m)]
        for ri, ci in indices:
            for j in range(n):
                matrix[ri][j] += 1
            for i in range(m):
                matrix[i][ci] += 1
        count = 0
        for row in matrix:
            for num in row:
                if num % 2 != 0:
                    count += 1
        return count