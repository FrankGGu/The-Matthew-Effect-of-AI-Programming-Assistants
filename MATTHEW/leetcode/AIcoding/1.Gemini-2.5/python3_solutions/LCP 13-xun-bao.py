import collections

class Solution:
    def shortestPath(self, grid: list[str]) -> int:
        m, n = len(grid), len(grid[0])

        start_r, start_c = -1, -1

        for r in range(m):
            for c in range(n):
                if grid[r][c] == 'S':
                    start_r, start_c = r, c
                    break
            if start_r != -1:
                break

        q = collections.deque([(start_r, start_c, 0, 0)])

        visited = set()
        visited.add((start_r, start_c, 0))

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while q:
            r, c, keys_mask, steps = q.popleft()

            if grid[r][c] == 'T':
                return steps

            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                if 0 <= nr < m and 0 <= nc < n and grid[nr][nc] != '#':
                    cell_char = grid[nr][nc]
                    new_keys_mask = keys_mask

                    if 'a' <= cell_char <= 'j':
                        key_idx = ord(cell_char) - ord('a')
                        new_keys_mask |= (1 << key_idx)
                    elif 'A' <= cell_char <= 'J':
                        door_idx = ord(cell_char) - ord('A')
                        if not (keys_mask & (1 << door_idx)):
                            continue

                    if (nr, nc, new_keys_mask) not in visited:
                        visited.add((nr, nc, new_keys_mask))
                        q.append((nr, nc, new_keys_mask, steps + 1))

        return -1