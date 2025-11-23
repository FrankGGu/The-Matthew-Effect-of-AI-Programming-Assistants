from collections import deque

def solve():
    n, m = map(int, input().split())
    grid = [list(input()) for _ in range(n)]

    start_row, start_col = -1, -1
    for i in range(n):
        for j in range(m):
            if grid[i][j] == 'S':
                start_row, start_col = i, j
                break
        if start_row != -1:
            break

    def is_valid(row, col):
        return 0 <= row < n and 0 <= col < m and grid[row][col] != 'W'

    def bfs():
        q = deque([(start_row, start_col, 0)])
        visited = set()
        visited.add((start_row, start_col))

        dirty_count = 0
        for i in range(n):
            for j in range(m):
                if grid[i][j] == 'D':
                    dirty_count += 1

        cleaned_count = 0

        while q:
            row, col, moves = q.popleft()

            if grid[row][col] == 'D':
                grid[row][col] = '.'
                cleaned_count += 1
                if cleaned_count == dirty_count:
                    return moves

            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
            for dr, dc in directions:
                new_row, new_col = row + dr, col + dc
                if is_valid(new_row, new_col) and (new_row, new_col) not in visited:
                    q.append((new_row, new_col, moves + 1))
                    visited.add((new_row, new_col))

        return -1

    result = bfs()
    print(result)

solve()