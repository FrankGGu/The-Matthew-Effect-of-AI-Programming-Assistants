from collections import deque

def orangesRotting(grid):
    rows, cols = len(grid), len(grid[0])
    queue = deque()
    fresh_count = 0

    for r in range(rows):
        for c in range(cols):
            if grid[r][c] == 2:
                queue.append((r, c))
            elif grid[r][c] == 1:
                fresh_count += 1

    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    minutes = 0

    while queue and fresh_count > 0:
        for _ in range(len(queue)):
            r, c = queue.popleft()
            for dr, dc in directions:
                new_r, new_c = r + dr, c + dc
                if 0 <= new_r < rows and 0 <= new_c < cols and grid[new_r][new_c] == 1:
                    grid[new_r][new_c] = 2
                    fresh_count -= 1
                    queue.append((new_r, new_c))
        minutes += 1

    return minutes if fresh_count == 0 else -1