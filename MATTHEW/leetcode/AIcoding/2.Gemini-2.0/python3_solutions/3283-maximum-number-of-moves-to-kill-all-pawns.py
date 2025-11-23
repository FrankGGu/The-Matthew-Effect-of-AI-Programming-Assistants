class Solution:
    def maxMovesToKillAllPawns(self, pawns: list[int], knights: list[int]) -> int:
        pawns.sort()
        knights.sort()

        n = len(pawns)
        m = len(knights)

        moves = 0

        knight_idx = 0

        for pawn_idx in range(n):
            while knight_idx < m and knights[knight_idx] <= pawns[pawn_idx] - 1:
                knight_idx += 1

            if knight_idx < m and knights[knight_idx] <= pawns[pawn_idx] + 1:
                moves += 1
                knight_idx += 1
            else:
                return moves

        return moves