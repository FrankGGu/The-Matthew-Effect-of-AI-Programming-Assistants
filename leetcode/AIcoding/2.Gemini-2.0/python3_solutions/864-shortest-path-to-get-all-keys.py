from collections import deque

class Solution:
    def shortestPathAllKeys(self, grid: list[str]) -> int:
        m, n = len(grid), len(grid[0])
        start_row, start_col = -1, -1
        num_keys = 0

        for i in range(m):
            for j in range(n):
                if grid[i][j] == '@':
                    start_row, start_col = i, j
                elif 'a' <= grid[i][j] <= 'z':
                    num_keys += 1

        q = deque([(start_row, start_col, 0, 0)])
        visited = set()
        visited.add((start_row, start_col, 0))

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while q:
            row, col, keys, steps = q.popleft()

            if keys == (1 << num_keys) - 1:
                return steps

            for dr, dc in directions:
                new_row, new_col = row + dr, col + dc

                if 0 <= new_row < m and 0 <= new_col < n and grid[new_row][new_col] != '#':
                    cell = grid[new_row][new_col]
                    new_keys = keys

                    if 'a' <= cell <= 'z':
                        new_keys |= (1 << (ord(cell) - ord('a')))
                    elif 'A' <= cell <= 'Z':
                        if not (keys & (1 << (ord(cell) - ord('A')))):
                            continue

                    if (new_row, new_col, new_keys) not in visited:
                        visited.add((new_row, new_col, new_keys))
                        q.append((new_row, new_col, new_keys, steps + 1))

        return -1