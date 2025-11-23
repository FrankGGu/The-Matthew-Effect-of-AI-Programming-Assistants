class Solution:
    def queensAttacktheKing(self, queens, king):
        directions = [(1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)]
        result = []
        for dx, dy in directions:
            x, y = king
            while 0 <= x + dx < 8 and 0 <= y + dy < 8:
                x += dx
                y += dy
                if [x, y] in queens:
                    result.append([x, y])
                    break
        return result