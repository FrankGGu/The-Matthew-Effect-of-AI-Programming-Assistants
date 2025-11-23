class Solution:
    def canEscape(self, maze: List[List[int]], start: List[int], destination: List[int]) -> bool:
        if not maze or not maze[0]:
            return False

        rows, cols = len(maze), len(maze[0])
        visited = set()

        def dfs(x, y):
            if (x, y) in visited:
                return False
            visited.add((x, y))
            if [x, y] == destination:
                return True

            # Move in all four directions
            for dx, dy in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                nx, ny = x, y
                while 0 <= nx + dx < rows and 0 <= ny + dy < cols and maze[nx + dx][ny + dy] == 0:
                    nx += dx
                    ny += dy
                if dfs(nx, ny):
                    return True

            return False

        return dfs(start[0], start[1])