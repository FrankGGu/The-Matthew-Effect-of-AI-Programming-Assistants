class Solution:
    def numSubmat(self, mat: List[List[int]]) -> int:
        if not mat:
            return 0

        rows, cols = len(mat), len(mat[0])
        heights = [[0] * cols for _ in range(rows)]
        result = 0

        for j in range(cols):
            for i in range(rows):
                if mat[i][j] == 1:
                    heights[i][j] = heights[i - 1][j] + 1 if i > 0 else 1

        for i in range(rows):
            for j in range(cols):
                if mat[i][j] == 1:
                    min_height = float('inf')
                    for k in range(j, -1, -1):
                        if mat[i][k] == 0:
                            break
                        min_height = min(min_height, heights[i][k])
                        result += min_height

        return result