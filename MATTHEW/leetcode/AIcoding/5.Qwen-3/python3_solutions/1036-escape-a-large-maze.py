from collections import deque

class Solution:
    def isEscapePossible(self, maze: List[List[int]], start: List[int], target: List[int]) -> bool:
        def bfs(start, target):
            visited = set()
            queue = deque([(start[0], start[1])])
            visited.add((start[0], start[1]))
            while queue:
                x, y = queue.popleft()
                if [x, y] == target:
                    return True
                for dx, dy in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < len(maze) and 0 <= ny < len(maze[0]) and maze[nx][ny] == 0 and (nx, ny) not in visited:
                        visited.add((nx, ny))
                        queue.append((nx, ny))
            return False

        return bfs(start, target) and bfs(target, start)