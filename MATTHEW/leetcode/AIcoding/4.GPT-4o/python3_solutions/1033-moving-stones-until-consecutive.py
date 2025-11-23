class Solution:
    def numMovesStones(self, a: int, b: int, c: int) -> List[int]:
        positions = sorted([a, b, c])
        min_moves = 0

        if positions[2] - positions[0] == 2:
            min_moves = 0
        elif positions[2] - positions[0] == 1 or (positions[1] - positions[0] == 1 or positions[2] - positions[1] == 1):
            min_moves = 1
        else:
            min_moves = 2

        max_moves = positions[2] - positions[0] - 2

        return [min_moves, max_moves]