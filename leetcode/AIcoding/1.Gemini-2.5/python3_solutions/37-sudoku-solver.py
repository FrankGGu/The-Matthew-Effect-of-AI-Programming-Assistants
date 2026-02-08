from typing import List

class Solution:
    def solveSudoku(self, board: List[List[str]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        self._solve(board)

    def _solve(self, board: List[List[str]]) -> bool:
        for r in range(9):
            for c in range(9):
                if board[r][c] == '.':
                    for num_char in "123456789":
                        if self._is_valid(board, r, c, num_char):
                            board[r][c] = num_char
                            if self._solve(board):
                                return True
                            board[r][c] = '.'
                    return False
        return True

    def _is_valid(self, board: List[List[str]], row: int, col: int, num_char: str) -> bool:
        # Check row
        for c_idx in range(9):
            if board[row][c_idx] == num_char:
                return False

        # Check column
        for r_idx in range(9):
            if board[r_idx][col] == num_char:
                return False

        # Check 3x3 subgrid
        start_row = (row // 3) * 3
        start_col = (col // 3) * 3
        for r_offset in range(3):
            for c_offset in range(3):
                if board[start_row + r_offset][start_col + c_offset] == num_char:
                    return False

        return True