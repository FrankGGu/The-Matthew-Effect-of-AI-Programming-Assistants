class Solution:
    def checkMove(self, board: List[List[str]], rMove: int, cMove: int, color: str) -> bool:
        m, n = len(board), len(board[0])
        board[rMove][cMove] = color
        directions = [(0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]

        for dr, dc in directions:
            r, c = rMove + dr, cMove + dc
            count = 0
            while 0 <= r < m and 0 <= c < n and board[r][c] != '.':
                if board[r][c] != color:
                    count += 1
                else:
                    if count >= 1:
                        board[rMove][cMove] = '.'
                        return True
                    else:
                        break
                r, c = r + dr, c + dc

        board[rMove][cMove] = '.'
        return False