class Solution:
    def checkMove(self, board: List[List[str]], r: int, c: int, color: str) -> bool:
        opponent = 'B' if color == 'W' else 'W'
        directions = [(1, 0), (0, 1), (1, 1), (1, -1), (-1, 0), (0, -1), (-1, -1), (-1, 1)]

        if board[r][c] != '.':
            return False

        for dr, dc in directions:
            x, y = r + dr, c + dc
            found_opponent = False

            while 0 <= x < 8 and 0 <= y < 8:
                if board[x][y] == opponent:
                    found_opponent = True
                elif board[x][y] == color:
                    if found_opponent:
                        return True
                    break
                else:
                    break
                x += dr
                y += dc

        return False