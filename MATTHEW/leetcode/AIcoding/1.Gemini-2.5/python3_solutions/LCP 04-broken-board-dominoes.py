class Solution:
    def brokenBoardDominoes(self, board: list[list[int]]) -> int:
        m = len(board)
        n = len(board[0])

        adj = {}

        match_right = {}

        dr = [-1, 1, 0, 0]
        dc = [0, 0, -1, 1]

        for r in range(m):
            for c in range(n):
                if board[r][c] == 0:
                    if (r + c) % 2 == 0:
                        adj[(r, c)] = []
                        for i in range(4):
                            nr, nc = r + dr[i], c + dc[i]
                            if 0 <= nr < m and 0 <= nc < n and board[nr][nc] == 0:
                                adj[(r, c)].append((nr, nc))
                    else:
                        match_right[(r, c)] = None

        visited = set()

        def dfs(u_node):
            visited.add(u_node)

            for v_node in adj.get(u_node, []):
                if match_right[v_node] is None or (match_right[v_node] not in visited and dfs(match_right[v_node])):
                    match_right[v_node] = u_node
                    return True
            return False

        max_matching = 0
        for r in range(m):
            for c in range(n):
                if board[r][c] == 0 and (r + c) % 2 == 0:
                    visited.clear()
                    if dfs((r, c)):
                        max_matching += 1

        return max_matching