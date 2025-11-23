import collections

class Solution:
    def minimumVisitedCells(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        if m == 1 and n == 1:
            return 1

        dist = [[float('inf')] * n for _ in range(m)]
        dist[0][0] = 1

        queue = collections.deque([(0, 0)])

        next_col = [[j for j in range(n + 1)] for _ in range(m)]
        next_row = [[i for i in range(m + 1)] for _ in range(n)]

        def find_next_col(r_idx, c_idx):
            if c_idx >= n:
                return n
            if next_col[r_idx][c_idx] == c_idx:
                return c_idx
            next_col[r_idx][c_idx] = find_next_col(r_idx, next_col[r_idx][c_idx])
            return next_col[r_idx][c_idx]

        def find_next_row(c_idx, r_idx):
            if r_idx >= m:
                return m
            if next_row[c_idx][r_idx] == r_idx:
                return r_idx
            next_row[c_idx][r_idx] = find_next_row(c_idx, next_row[c_idx][r_idx])
            return next_row[c_idx][r_idx]

        while queue:
            r, c = queue.popleft()
            current_dist = dist[r][c]

            if r == m - 1 and c == n - 1:
                return current_dist

            # Explore horizontal moves
            max_jump_col = c + grid[r][c]
            curr_j = find_next_col(r, c + 1) # Start from the next unvisited column after 'c'

            while curr_j <= max_jump_col and curr_j < n:
                if dist[r][curr_j] == float('inf'):
                    dist[r][curr_j] = current_dist + 1
                    queue.append((r, curr_j))
                    next_col[r][curr_j] = find_next_col(r, curr_j + 1) # Mark curr_j as visited
                curr_j = find_next_col(r, curr_j + 1) # Move to the next unvisited column

            # Explore vertical moves
            max_jump_row = r + grid[r][c]
            curr_i = find_next_row(c, r + 1) # Start from the next unvisited row after 'r'

            while curr_i <= max_jump_row and curr_i < m:
                if dist[curr_i][c] == float('inf'):
                    dist[curr_i][c] = current_dist + 1
                    queue.append((curr_i, c))
                    next_row[c][curr_i] = find_next_row(c, curr_i + 1) # Mark curr_i as visited
                curr_i = find_next_row(c, curr_i + 1) # Move to the next unvisited row

        return -1