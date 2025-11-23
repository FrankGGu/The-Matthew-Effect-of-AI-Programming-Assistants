class Solution:
    def updateBoard(self, board: List[List[str]], click: List[int]) -> List[List[str]]:
        if not board or not board[0]:
            return board

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]
        rows, cols = len(board), len(board[0])
        x, y = click

        if board[x][y] == 'M':
            board[x][y] = 'X'
            return board

        def dfs(i, j):
            if board[i][j] != 'E':
                return
            mine_count = 0
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < rows and 0 <= nj < cols and board[ni][nj] == 'M':
                    mine_count += 1
            if mine_count > 0:
                board[i][j] = str(mine_count)
                return
            board[i][j] = 'B'
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < rows and 0 <= nj < cols:
                    dfs(ni, nj)

        dfs(x, y)
        return board