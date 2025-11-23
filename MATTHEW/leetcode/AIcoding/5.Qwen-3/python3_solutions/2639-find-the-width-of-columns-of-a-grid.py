class Solution:
    def gridInterview(self, grid: List[List[str]]) -> List[int]:
        if not grid or not grid[0]:
            return []
        rows = len(grid)
        cols = len(grid[0])
        result = [0] * cols
        for j in range(cols):
            max_len = 0
            for i in range(rows):
                max_len = max(max_len, len(grid[i][j]))
            result[j] = max_len
        return result