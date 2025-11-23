class Solution:
    def magicalBoard(self, board: List[List[str]]) -> bool:
        rows = len(board)
        cols = len(board[0]) if rows > 0 else 0

        for i in range(rows):
            for j in range(cols):
                if board[i][j] == '1':
                    # Check if the current '1' is part of a valid 2x2 square
                    if i + 1 < rows and j + 1 < cols:
                        if board[i][j+1] == '1' and board[i+1][j] == '1' and board[i+1][j+1] == '1':
                            return False
        return True