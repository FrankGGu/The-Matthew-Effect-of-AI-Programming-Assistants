class Solution:
    def numMovesStones(self, a: int, b: int, c: int) -> List[int]:
        stones = sorted([a, b, c])
        a, b, c = stones[0], stones[1], stones[2]
        if c - a == 2:
            return [0, 0]
        min_moves = 1
        if b - a <= 2 or c - b <= 2:
            min_moves = 1
        else:
            min_moves = 2
        max_moves = c - a - 2
        return [min_moves, max_moves]