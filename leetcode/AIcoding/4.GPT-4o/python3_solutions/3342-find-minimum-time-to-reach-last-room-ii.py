from collections import deque

def minimumTime(grid):
    m, n = len(grid), len(grid[0])
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    queue = deque([(0, 0, 0)])  # (row, col, time)
    visited = set()
    visited.add((0, 0))

    while queue:
        x, y, time = queue.popleft()

        if (x, y) == (m - 1, n - 1):
            return time

        for dx, dy in directions:
            nx, ny = x + dx, y + dy
            if 0 <= nx < m and 0 <= ny < n:
                wait_time = grid[nx][ny]
                new_time = time + 1 + (wait_time if (time + 1) % 3 == 0 else 0)
                if (nx, ny) not in visited or new_time < visited[(nx, ny)]:
                    visited.add((nx, ny))
                    queue.append((nx, ny, new_time))

    return -1