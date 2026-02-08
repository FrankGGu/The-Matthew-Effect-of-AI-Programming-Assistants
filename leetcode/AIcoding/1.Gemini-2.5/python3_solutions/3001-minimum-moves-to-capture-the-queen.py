class Solution:
    def minMovesToCaptureTheQueen(self, a: int, b: int, c: int, d: int, e: int, f: int) -> int:
        rR, cR = a, b  # Rook position
        rB, cB = c, d  # Bishop position
        rQ, cQ = e, f  # Queen position

        # Helper to check if a Rook's path is blocked by the Bishop
        def is_rook_blocked(r_start, c_start, r_end, c_end, r_blocker, c_blocker):
            if r_start == r_end:  # Horizontal path
                return r_blocker == r_start and min(c_start, c_end) < c_blocker < max(c_start, c_end)
            elif c_start == c_end:  # Vertical path
                return c_blocker == c_start and min(r_start, r_end) < r_blocker < max(r_start, r_end)
            return False  # Not a straight path for Rook

        # Helper to check if a Bishop's path is blocked by the Rook
        def is_bishop_blocked(r_start, c_start, r_end, c_end, r_blocker, c_blocker):
            if abs(r_start - r_end) == abs(c_start - c_end):  # Diagonal path
                # Check if blocker is on the same diagonal
                if (r_blocker + c_blocker == r_start + c_start) or \
                   (r_blocker - c_blocker == r_start - c_start):
                    # Check if blocker is between start and end
                    if min(r_start, r_end) < r_blocker < max(r_start, r_end):
                        return True
            return False  # Not a diagonal path for Bishop or blocker not on same diagonal/between

        # Check if Rook can capture Queen in 1 move
        rook_can_capture_in_1_move = False
        if rR == rQ or cR == cQ:  # Rook is on the same row or column as Queen
            if not is_rook_blocked(rR, cR, rQ, cQ, rB, cB):
                rook_can_capture_in_1_move = True

        # Check if Bishop can capture Queen in 1 move
        bishop_can_capture_in_1_move = False
        if abs(rB - rQ) == abs(cB - cQ):  # Bishop is on the same diagonal as Queen
            if not is_bishop_blocked(rB, cB, rQ, cQ, rR, cR):
                bishop_can_capture_in_1_move = True

        if rook_can_capture_in_1_move or bishop_can_capture_in_1_move:
            return 1
        else:
            # If neither piece can capture in 1 move, it implies that it will take 2 moves.
            # This is a common pattern for "Minimum Moves" problems where the answer is always 1 or 2.
            # A piece can always reach any square (that it can reach) in at most 2 moves on an empty board,
            # and the problem implies that if a direct path is blocked, an alternative 2-move path exists
            # by moving off the blocking line and then capturing.
            return 2