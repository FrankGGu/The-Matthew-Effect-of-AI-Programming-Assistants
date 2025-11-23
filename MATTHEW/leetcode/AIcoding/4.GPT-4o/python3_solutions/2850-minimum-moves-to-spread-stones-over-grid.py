class Solution:
    def minimumMoves(self, grid: List[List[int]]) -> int:
        from collections import deque

        n = len(grid)
        m = len(grid[0])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        def is_valid(x, y):
            return 0 <= x < n and 0 <= y < m and grid[x][y] == 0

        def bfs():
            queue = deque([(0, 0, 0)])  # (x, y, moves)
            visited = set((0, 0))
            while queue:
                x, y, moves = queue.popleft()
                if x == n - 1 and y == m - 1:
                    return moves
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if is_valid(nx, ny) and (nx, ny) not in visited:
                        visited.add((nx, ny))
                        queue.append((nx, ny, moves + 1))
            return float('inf')

        return bfs()