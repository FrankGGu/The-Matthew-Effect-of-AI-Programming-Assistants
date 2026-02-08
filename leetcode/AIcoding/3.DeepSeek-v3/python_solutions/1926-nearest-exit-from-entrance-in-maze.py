from collections import deque

class Solution:
    def nearestExit(self, maze: List[List[str]], entrance: List[int]) -> int:
        rows, cols = len(maze), len(maze[0])
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        queue = deque()
        queue.append((entrance[0], entrance[1], 0))
        maze[entrance[0]][entrance[1]] = '+'

        while queue:
            x, y, steps = queue.popleft()

            for dx, dy in directions:
                nx, ny = x + dx, y + dy

                if 0 <= nx < rows and 0 <= ny < cols and maze[nx][ny] == '.':
                    if nx == 0 or nx == rows - 1 or ny == 0 or ny == cols - 1:
                        return steps + 1
                    maze[nx][ny] = '+'
                    queue.append((nx, ny, steps + 1))

        return -1