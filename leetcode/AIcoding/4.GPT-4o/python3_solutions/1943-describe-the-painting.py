class Solution:
    def describePainting(self, painting: List[List[int]]) -> List[str]:
        n = len(painting)
        m = len(painting[0]) if n > 0 else 0
        result = []

        for i in range(n):
            for j in range(m):
                if painting[i][j] != 0:
                    color = painting[i][j]
                    width = 0
                    while j + width < m and painting[i][j + width] == color:
                        width += 1
                    height = 0
                    while i + height < n and all(painting[i + height][j + k] == color for k in range(width)):
                        height += 1
                    result.append(f"{color} {width} {height}")
                    for x in range(height):
                        for y in range(width):
                            painting[i + x][j + y] = 0
        return result