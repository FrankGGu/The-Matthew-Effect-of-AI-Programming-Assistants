from collections import deque

def solve():
    n, m = map(int, input().split())
    grid = [input() for _ in range(n)]

    start_row, start_col = -1, -1
    for r in range(n):
        for c in range(m):
            if grid[r][c] == 'S':
                start_row, start_col = r, c
                break
        if start_row != -1:
            break

    q = deque([(start_row, start_col, 0)])
    visited = set()
    visited.add((start_row, start_col))

    while q:
        row, col, steps = q.popleft()

        if grid[row][col] == 'E':
            print(steps)
            return

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        for dr, dc in directions:
            new_row = row + dr
            new_col = col + dc

            if 0 <= new_row < n and 0 <= new_col < m and grid[new_row][new_col] != '#' and (new_row, new_col) not in visited:
                q.append((new_row, new_col, steps + 1))
                visited.add((new_row, new_col))

    print(-1)

solve()