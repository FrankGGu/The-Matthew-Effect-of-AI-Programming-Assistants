class Solution:
    def maxMoves(self, pawns: List[str]) -> int:
        rows = len(pawns)
        cols = len(pawns[0])
        moves = 0

        for col in range(cols):
            for row in range(rows-1, -1, -1):
                if pawns[row][col] == 'P':
                    moves += (rows - 1 - row)
                    break

        return moves