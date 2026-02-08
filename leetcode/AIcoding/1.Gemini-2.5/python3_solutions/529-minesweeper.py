import collections

class Solution:
    def updateBoard(self, board: List[List[str]], click: List[int]) -> List[List[str]]:
        R, C = len(board), len(board[0])
        r_click, c_click = click[0], click[1]

        if board[r_click][c_click] == 'M':
            board[r_click][c_click] = 'X'
            return board

        dr = [-1, -1, -1, 0, 0, 1, 1, 1]
        dc = [-1, 0, 1, -1, 1, -1, 0, 1]

        q = collections.deque()
        q.append((r_click, c_click))

        while q:
            r, c = q.popleft()

            if board[r][c] != 'E':
                continue

            mine_count = 0
            empty_neighbors_to_queue = []
            for i in range(8):
                nr, nc = r + dr[i], c + dc[i]
                if 0 <= nr < R and 0 <= nc < C:
                    if board[nr][nc] == 'M':
                        mine_count += 1
                    elif board[nr][nc] == 'E':
                        empty_neighbors_to_queue.append((nr, nc))

            if mine_count > 0:
                board[r][c] = str(mine_count)
            else:
                board[r][c] = 'B'
                for nr, nc in empty_neighbors_to_queue:
                    q.append((nr, nc))

        return board