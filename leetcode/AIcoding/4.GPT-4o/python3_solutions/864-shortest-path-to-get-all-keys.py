from collections import deque

class Solution:
    def shortestPathAllKeys(self, grid: List[str]) -> int:
        rows, cols = len(grid), len(grid[0])
        all_keys = 0
        start = (0, 0)
        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == '@':
                    start = (r, c)
                elif grid[r][c].islower():
                    all_keys += 1

        def bfs():
            queue = deque([(start[0], start[1], 0, 0)])  # (row, col, keys, steps)
            visited = set()
            visited.add((start[0], start[1], 0))
            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

            while queue:
                r, c, keys, steps = queue.popleft()
                if keys == (1 << all_keys) - 1:
                    return steps

                for dr, dc in directions:
                    nr, nc = r + dr, c + dc
                    if 0 <= nr < rows and 0 <= nc < cols:
                        cell = grid[nr][nc]
                        if cell == '#':
                            continue
                        new_keys = keys
                        if cell.islower():
                            new_keys |= (1 << (ord(cell) - ord('a')))
                        elif cell.isupper() and not (keys & (1 << (ord(cell) - ord('A')))):
                            continue
                        if (nr, nc, new_keys) not in visited:
                            visited.add((nr, nc, new_keys))
                            queue.append((nr, nc, new_keys, steps + 1))
            return -1

        return bfs()