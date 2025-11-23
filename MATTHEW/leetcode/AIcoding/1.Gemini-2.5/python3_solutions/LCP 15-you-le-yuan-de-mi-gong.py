from collections import deque

class Solution:
    def hasPath(self, maze: list[list[int]], start: list[int], destination: list[int]) -> bool:
        rows, cols = len(maze), len(maze[0])
        q = deque([(start[0], start[1])])
        visited = {(start[0], start[1])}

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while q:
            r, c = q.popleft()

            if r == destination[0] and c == destination[1]:
                return True

            for dr, dc in directions:
                nr, nc = r, c
                while 0 <= nr + dr < rows and 0 <= nc + dc < cols and maze[nr + dr][nc + dc] == 0:
                    nr += dr
                    nc += dc

                if (nr, nc) not in visited:
                    visited.add((nr, nc))
                    q.append((nr, nc))

        return False