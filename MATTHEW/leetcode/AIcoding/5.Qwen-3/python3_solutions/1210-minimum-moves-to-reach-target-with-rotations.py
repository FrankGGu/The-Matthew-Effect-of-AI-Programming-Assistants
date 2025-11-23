from collections import deque

class Solution:
    def minimumMoves(self, grid: List[List[int]]) -> int:
        n = len(grid)
        visited = set()

        def is_valid(x1, y1, x2, y2):
            return 0 <= x1 < n and 0 <= y1 < n and 0 <= x2 < n and 0 <= y2 < n and grid[x1][y1] == 0 and grid[x2][y2] == 0

        def get_neighbors(x1, y1, x2, y2):
            neighbors = []
            # Move right
            if is_valid(x1, y1 + 1, x2, y2 + 1):
                neighbors.append((x1, y1 + 1, x2, y2 + 1))
            # Move down
            if is_valid(x1 + 1, y1, x2 + 1, y2):
                neighbors.append((x1 + 1, y1, x2 + 1, y2))
            # Rotate clockwise
            if is_valid(x1, y1, x1 + 1, y1 - 1) and is_valid(x1, y1, x1 + 1, y1 - 1):
                neighbors.append((x1, y1, x1 + 1, y1 - 1))
            # Rotate counter-clockwise
            if is_valid(x1, y1, x1 - 1, y1 + 1) and is_valid(x1, y1, x1 - 1, y1 + 1):
                neighbors.append((x1, y1, x1 - 1, y1 + 1))
            return neighbors

        queue = deque()
        queue.append((0, 0, 0, 1))
        visited.add((0, 0, 0, 1))

        moves = 0

        while queue:
            for _ in range(len(queue)):
                x1, y1, x2, y2 = queue.popleft()
                if (x1, y1, x2, y2) == (n - 1, n - 2, n - 1, n - 1):
                    return moves
                for neighbor in get_neighbors(x1, y1, x2, y2):
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
            moves += 1

        return -1