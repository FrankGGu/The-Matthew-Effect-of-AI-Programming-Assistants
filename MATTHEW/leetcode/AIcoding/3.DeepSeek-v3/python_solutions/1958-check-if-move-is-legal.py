class Solution:
    def checkMove(self, board: List[List[str]], rMove: int, cMove: int, color: str) -> bool:
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1), (1, 1), (1, -1), (-1, 1), (-1, -1)]
        board[rMove][cMove] = color
        for dr, dc in directions:
            r, c = rMove + dr, cMove + dc
            length = 1
            while 0 <= r < 8 and 0 <= c < 8:
                if board[r][c] == '.':
                    break
                length += 1
                if board[r][c] == color:
                    if length >= 3:
                        return True
                    break
                r += dr
                c += dc
        return False