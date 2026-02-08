class Solution:
    def minimumMoves(self, grid: List[List[int]]) -> int:
        from collections import deque

        n = len(grid)
        start_pos = None
        dirty = []

        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    dirty.append((i, j))
                elif grid[i][j] == 2:
                    start_pos = (i, j)

        dirty = tuple(dirty)
        q = deque()
        q.append((start_pos[0], start_pos[1], dirty))
        visited = set()
        visited.add((start_pos[0], start_pos[1], dirty))
        moves = 0

        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        while q:
            for _ in range(len(q)):
                x, y, remaining = q.popleft()
                if not remaining:
                    return moves
                for dx, dy in dirs:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < n and 0 <= ny < n and grid[nx][ny] != -1:
                        new_remaining = list(remaining)
                        if (nx, ny) in new_remaining:
                            new_remaining.remove((nx, ny))
                        new_remaining = tuple(new_remaining)
                        if (nx, ny, new_remaining) not in visited:
                            visited.add((nx, ny, new_remaining))
                            q.append((nx, ny, new_remaining))
            moves += 1

        return -1