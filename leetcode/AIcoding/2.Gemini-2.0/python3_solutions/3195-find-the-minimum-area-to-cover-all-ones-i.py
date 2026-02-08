class Solution:
    def minAreaRect(self, image: List[str], x: int, y: int) -> int:
        rows = len(image)
        cols = len(image[0])

        min_x, min_y = float('inf'), float('inf')
        max_x, max_y = float('-inf'), float('-inf')

        for i in range(rows):
            for j in range(cols):
                if image[i][j] == '1':
                    min_x = min(min_x, i)
                    min_y = min(min_y, j)
                    max_x = max(max_x, i)
                    max_y = max(max_y, j)

        return (max_x - min_x + 1) * (max_y - min_y + 1)