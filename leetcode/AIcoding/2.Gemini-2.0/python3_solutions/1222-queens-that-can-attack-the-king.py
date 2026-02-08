class Solution:
    def queensAttacktheKing(self, queens: List[List[int]], king: List[int]) -> List[List[int]]:
        result = []
        queen_set = set(tuple(q) for q in queens)

        for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]:
            for i in range(1, 9):
                x = king[0] + i * dx
                y = king[1] + i * dy
                if 0 <= x < 8 and 0 <= y < 8:
                    if (x, y) in queen_set:
                        result.append([x, y])
                        break
                else:
                    break

        return result