class Solution:
    def drawLine(self, width: int, height: int, x1: int, x2: int, y: int) -> List[str]:
        result = []
        for i in range(height):
            row = []
            for j in range(width):
                if i == y and x1 <= j <= x2:
                    row.append('X')
                else:
                    row.append('.')
            result.append(''.join(row))
        return result