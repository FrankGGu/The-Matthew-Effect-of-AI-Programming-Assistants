class Solution:
    def queensAttacktheKing(self, queens: List[List[int]], king: List[int]) -> List[List[int]]:
        queens_set = {(i, j) for i, j in queens}
        directions = [(-1, -1), (-1, 0), (-1, 1),
                      (0, -1),          (0, 1),
                      (1, -1),  (1, 0), (1, 1)]
        res = []
        for di, dj in directions:
            x, y = king
            while 0 <= x < 8 and 0 <= y < 8:
                x += di
                y += dj
                if (x, y) in queens_set:
                    res.append([x, y])
                    break
        return res