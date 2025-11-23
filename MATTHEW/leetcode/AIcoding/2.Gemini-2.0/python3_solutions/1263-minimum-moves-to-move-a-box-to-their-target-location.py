import heapq

def minPushBox(grid):
    m, n = len(grid), len(grid[0])
    for i in range(m):
        for j in range(n):
            if grid[i][j] == 'S':
                sx, sy = i, j
            elif grid[i][j] == 'B':
                bx, by = i, j
            elif grid[i][j] == 'T':
                tx, ty = i, j

    def is_valid(x, y):
        return 0 <= x < m and 0 <= y < n and grid[x][y] != '#'

    def can_reach(sx, sy, ex, ey, bx, by):
        visited = set()
        queue = [(sx, sy)]
        visited.add((sx, sy))
        while queue:
            x, y = queue.pop(0)
            if x == ex and y == ey:
                return True
            for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                nx, ny = x + dx, y + dy
                if is_valid(nx, ny) and (nx, ny) != (bx, by) and (nx, ny) not in visited:
                    queue.append((nx, ny))
                    visited.add((nx, ny))
        return False

    pq = [(0, bx, by, sx, sy)]
    visited = set()
    visited.add((bx, by, sx, sy))

    while pq:
        moves, bx, by, sx, sy = heapq.heappop(pq)
        if bx == tx and by == ty:
            return moves

        for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
            nbx, nby = bx + dx, by + dy
            nsx, nsy = bx - dx, by - dy
            if is_valid(nbx, nby) and is_valid(nsx, nsy) and (nbx, nby, bx, by) not in visited and can_reach(sx, sy, nsx, nsy, bx, by):
                heapq.heappush(pq, (moves + 1, nbx, nby, bx, by))
                visited.add((nbx, nby, bx, by))

    return -1