import collections

class Solution:
    def shortestPathAllKeys(self, grid: list[str]) -> int:
        R, C = len(grid), len(grid[0])

        start_r, start_c = -1, -1
        max_key_idx = -1

        for r in range(R):
            for c in range(C):
                if grid[r][c] == '@':
                    start_r, start_c = r, c
                elif 'a' <= grid[r][c] <= 'f':
                    max_key_idx = max(max_key_idx, ord(grid[r][c]) - ord('a'))

        num_keys = max_key_idx + 1 if max_key_idx != -1 else 0
        target_keys_mask = (1 << num_keys) - 1

        q = collections.deque([(start_r, start_c, 0, 0)]) # (r, c, keys_mask, steps)
        visited = set([(start_r, start_c, 0)]) # (r, c, keys_mask)

        dr = [-1, 1, 0, 0]
        dc = [0, 0, -1, 1]

        while q:
            r, c, keys, steps = q.popleft()

            if keys == target_keys_mask:
                return steps

            for i in range(4):
                nr, nc = r + dr[i], c + dc[i]

                if 0 <= nr < R and 0 <= nc < C:
                    cell = grid[nr][nc]

                    if cell == '#':
                        continue

                    if 'A' <= cell <= 'F': # It's a lock
                        lock_bit = ord(cell) - ord('A')
                        if not (keys & (1 << lock_bit)): # Don't have the key for this lock
                            continue

                    new_keys = keys
                    if 'a' <= cell <= 'f': # It's a key
                        key_bit = ord(cell) - ord('a')
                        new_keys = keys | (1 << key_bit)

                    if (nr, nc, new_keys) not in visited:
                        visited.add((nr, nc, new_keys))
                        q.append((nr, nc, new_keys, steps + 1))

        return -1