class Solution:
    def numSubmat(self, mat: List[List[int]]) -> int:
        rows = len(mat)
        cols = len(mat[0])
        heights = [[0] * cols for _ in range(rows)]
        for i in range(rows):
            for j in range(cols):
                if mat[i][j] == 1:
                    heights[i][j] = (heights[i - 1][j] if i > 0 else 0) + 1
        count = 0
        for i in range(rows):
            for j in range(cols):
                min_height = float('inf')
                for k in range(j, -1, -1):
                    min_height = min(min_height, heights[i][k])
                    if min_height == 0:
                        break
                    count += min_height
        return count