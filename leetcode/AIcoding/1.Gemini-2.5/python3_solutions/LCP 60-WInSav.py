import collections

class Solution:
    def bubbleShooter(self, board: list[list[int]], r: int, c: int) -> list[list[int]]:
        m = len(board)
        n = len(board[0])

        if board[r][c] == 0:
            return board

        target_color = board[r][c]

        q = collections.deque([(r, c)])
        visited = set([(r, c)])

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        while q:
            curr_r, curr_c = q.popleft()

            for dr, dc in directions:
                new_r, new_c = curr_r + dr, curr_c + dc

                if 0 <= new_r < m and 0 <= new_c < n and \
                   (new_r, new_c) not in visited and \
                   board[new_r][new_c] == target_color:

                    visited.add((new_r, new_c))
                    q.append((new_r, new_c))

        for vr, vc in visited:
            board[vr][vc] = 0

        for j in range(n):
            temp_col_elements = []
            for i in range(m - 1, -1, -1):
                if board[i][j] != 0:
                    temp_col_elements.append(board[i][j])

            for k in range(len(temp_col_elements)):
                board[m - 1 - k][j] = temp_col_elements[k]

            for k in range(len(temp_col_elements), m):
                board[m - 1 - k][j] = 0

        return board