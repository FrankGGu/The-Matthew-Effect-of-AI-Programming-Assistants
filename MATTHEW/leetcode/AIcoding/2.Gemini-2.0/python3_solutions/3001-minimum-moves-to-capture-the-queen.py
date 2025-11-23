class Solution:
    def minMovesToCaptureTheQueen(self, rookRow: int, rookCol: int, bishopRow: int, bishopCol: int, queenRow: int, queenCol: int) -> int:
        rook_moves = float('inf')
        bishop_moves = float('inf')

        # Rook moves
        blocked_rook_up = False
        for r in range(rookRow - 1, -1, -1):
            if r == queenRow and rookCol == queenCol and not blocked_rook_up:
                rook_moves = min(rook_moves, abs(rookRow - queenRow))
                break
            elif r == bishopRow and rookCol == bishopCol:
                blocked_rook_up = True
            elif r == queenRow and rookCol == queenCol:
                break
            elif r < queenRow:
                break

        blocked_rook_down = False
        for r in range(rookRow + 1, 8):
            if r == queenRow and rookCol == queenCol and not blocked_rook_down:
                rook_moves = min(rook_moves, abs(rookRow - queenRow))
                break
            elif r == bishopRow and rookCol == bishopCol:
                blocked_rook_down = True
            elif r == queenRow and rookCol == queenCol:
                break
            elif r > queenRow:
                break

        blocked_rook_left = False
        for c in range(rookCol - 1, -1, -1):
            if rookRow == queenRow and c == queenCol and not blocked_rook_left:
                rook_moves = min(rook_moves, abs(rookCol - queenCol))
                break
            elif rookRow == bishopRow and c == bishopCol:
                blocked_rook_left = True
            elif rookRow == queenRow and c == queenCol:
                break
            elif c < queenCol:
                break

        blocked_rook_right = False
        for c in range(rookCol + 1, 8):
            if rookRow == queenRow and c == queenCol and not blocked_rook_right:
                rook_moves = min(rook_moves, abs(rookCol - queenCol))
                break
            elif rookRow == bishopRow and c == bishopCol:
                blocked_rook_right = True
            elif rookRow == queenRow and c == queenCol:
                break
            elif c > queenCol:
                break

        # Bishop moves
        blocked_bishop_up_left = False
        r, c = bishopRow - 1, bishopCol - 1
        while r >= 0 and c >= 0:
            if r == queenRow and c == queenCol and not blocked_bishop_up_left:
                bishop_moves = min(bishop_moves, abs(bishopRow - queenRow))
                break
            elif r == rookRow and c == rookCol:
                blocked_bishop_up_left = True
            elif r == queenRow and c == queenCol:
                break
            elif r < queenRow and c < queenCol:
                break
            r -= 1
            c -= 1

        blocked_bishop_up_right = False
        r, c = bishopRow - 1, bishopCol + 1
        while r >= 0 and c < 8:
            if r == queenRow and c == queenCol and not blocked_bishop_up_right:
                bishop_moves = min(bishop_moves, abs(bishopRow - queenRow))
                break
            elif r == rookRow and c == rookCol:
                blocked_bishop_up_right = True
            elif r == queenRow and c == queenCol:
                break
            elif r < queenRow and c > queenCol:
                break
            r -= 1
            c += 1

        blocked_bishop_down_left = False
        r, c = bishopRow + 1, bishopCol - 1
        while r < 8 and c >= 0:
            if r == queenRow and c == queenCol and not blocked_bishop_down_left:
                bishop_moves = min(bishop_moves, abs(bishopRow - queenRow))
                break
            elif r == rookRow and c == rookCol:
                blocked_bishop_down_left = True
            elif r == queenRow and c == queenCol:
                break
            elif r > queenRow and c < queenCol:
                break
            r += 1
            c -= 1

        blocked_bishop_down_right = False
        r, c = bishopRow + 1, bishopCol + 1
        while r < 8 and c < 8:
            if r == queenRow and c == queenCol and not blocked_bishop_down_right:
                bishop_moves = min(bishop_moves, abs(bishopRow - queenRow))
                break
            elif r == rookRow and c == rookCol:
                blocked_bishop_down_right = True
            elif r == queenRow and c == queenCol:
                break
            elif r > queenRow and c > queenCol:
                break
            r += 1
            c += 1

        return 1 if rook_moves < bishop_moves else 1 if bishop_moves < rook_moves else 0