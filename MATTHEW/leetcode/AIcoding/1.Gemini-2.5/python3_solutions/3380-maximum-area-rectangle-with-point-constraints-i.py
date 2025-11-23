class Solution:
    def maxAreaRect(self, points: list[list[int]]) -> int:
        if not points:
            return 0

        min_x = float('inf')
        max_x = float('-inf')
        min_y = float('inf')
        max_y = float('-inf')

        for x, y in points:
            min_x = min(min_x, x)
            max_x = max(max_x, x)
            min_y = min(min_y, y)
            max_y = max(max_y, y)

        width = max_x - min_x
        height = max_y - min_y

        return width * height