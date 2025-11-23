class Solution:
    def countBattleships(self, board: List[List[str]]) -> int:
        count = 0
        rows = len(board)
        cols = len(board[0]) if rows > 0 else 0

        for i in range(rows):
            for j in range(cols):
                if board[i][j] == 'X':
                    if (i > 0 and board[i-1][j] == 'X') or (j > 0 and board[i][j-1] == 'X'):
                        continue
                    else:
                        count += 1

        return count