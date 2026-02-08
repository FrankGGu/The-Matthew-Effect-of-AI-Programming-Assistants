class Solution:
    def numRookCaptures(self, board: List[List[str]]) -> int:
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        rook_position = None

        for r in range(8):
            for c in range(8):
                if board[r][c] == 'R':
                    rook_position = (r, c)
                    break
            if rook_position:
                break

        captures = 0

        for dr, dc in directions:
            r, c = rook_position
            while 0 <= r < 8 and 0 <= c < 8:
                r += dr
                c += dc
                if 0 <= r < 8 and 0 <= c < 8:
                    if board[r][c] == 'B':
                        break
                    if board[r][c] == 'p':
                        captures += 1
                        break

        return captures