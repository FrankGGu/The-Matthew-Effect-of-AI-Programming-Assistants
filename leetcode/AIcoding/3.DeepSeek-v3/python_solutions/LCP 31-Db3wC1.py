class Solution:
    def escapeMaze(self, maze: List[List[str]]) -> bool:
        T = len(maze)
        m = len(maze[0])
        n = len(maze[0][0])
        dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        memo = set()

        def dfs(t, x, y, magic1, magic2):
            if (t, x, y, magic1, magic2) in memo:
                return False
            if x == m - 1 and y == n - 1:
                return True
            if t == T - 1:
                return False
            for dx, dy in dirs:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n:
                    if maze[t + 1][nx][ny] == '.':
                        if dfs(t + 1, nx, ny, magic1, magic2):
                            return True
                    else:
                        if not magic1:
                            if dfs(t + 1, nx, ny, True, magic2):
                                return True
                        if not magic2:
                            for nt in range(t + 1, T):
                                if dfs(nt, nx, ny, magic1, True):
                                    return True
            memo.add((t, x, y, magic1, magic2))
            return False

        return dfs(0, 0, 0, False, False)