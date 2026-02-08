from collections import deque

class Solution:
    def hasPath(self, maze, start, destination):
        m, n = len(maze), len(maze[0])
        visited = set()
        queue = deque([start])
        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while queue:
            row, col = queue.popleft()
            if (row, col) == (destination[0], destination[1]):
                return True

            if (row, col) in visited:
                continue
            visited.add((row, col))

            for dr, dc in directions:
                new_row, new_col = row, col
                while 0 <= new_row + dr < m and 0 <= new_col + dc < n and maze[new_row + dr][new_col + dc] == 0:
                    new_row += dr
                    new_col += dc
                if (new_row, new_col) not in visited:
                    queue.append((new_row, new_col))

        return False