class Solution:
    def longestSpecialPath(self, grid: List[List[int]]) -> int:
        from collections import deque

        m, n = len(grid), len(grid[0])
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        def is_valid(x, y, prev_value):
            return 0 <= x < m and 0 <= y < n and grid[x][y] > prev_value

        def bfs(start_x, start_y):
            queue = deque([(start_x, start_y, 0)])
            max_length = 0

            while queue:
                x, y, length = queue.popleft()
                max_length = max(max_length, length)

                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if is_valid(nx, ny, grid[x][y]):
                        queue.append((nx, ny, length + 1))

            return max_length

        longest_path = 0
        for i in range(m):
            for j in range(n):
                longest_path = max(longest_path, bfs(i, j))

        return longest_path