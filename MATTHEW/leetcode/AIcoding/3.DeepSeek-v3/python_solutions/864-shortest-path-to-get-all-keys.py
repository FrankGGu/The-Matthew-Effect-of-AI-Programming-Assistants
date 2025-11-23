from collections import deque

class Solution:
    def shortestPathAllKeys(self, grid: List[str]) -> int:
        m, n = len(grid), len(grid[0])
        start_x = start_y = total_keys = 0
        for i in range(m):
            for j in range(n):
                if grid[i][j] == '@':
                    start_x, start_y = i, j
                elif grid[i][j].islower():
                    total_keys += 1

        target_mask = (1 << total_keys) - 1
        visited = set()
        queue = deque([(start_x, start_y, 0, 0)])
        visited.add((start_x, start_y, 0))

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        while queue:
            x, y, keys, steps = queue.popleft()
            if keys == target_mask:
                return steps

            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and grid[nx][ny] != '#':
                    cell = grid[nx][ny]
                    new_keys = keys
                    if cell.islower():
                        new_keys = keys | (1 << (ord(cell) - ord('a')))
                    elif cell.isupper():
                        if not (keys & (1 << (ord(cell.lower()) - ord('a')))):
                            continue

                    if (nx, ny, new_keys) not in visited:
                        visited.add((nx, ny, new_keys))
                        queue.append((nx, ny, new_keys, steps + 1))

        return -1