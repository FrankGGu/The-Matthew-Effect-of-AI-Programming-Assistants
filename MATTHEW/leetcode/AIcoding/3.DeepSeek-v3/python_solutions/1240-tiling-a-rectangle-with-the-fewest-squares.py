class Solution:
    def tilingRectangle(self, n: int, m: int) -> int:
        self.res = float('inf')
        grid = [[False] * m for _ in range(n)]

        def dfs(count):
            if count >= self.res:
                return

            # Find the first empty cell
            x, y = -1, -1
            for i in range(n):
                for j in range(m):
                    if not grid[i][j]:
                        x, y = i, j
                        break
                if x != -1:
                    break

            if x == -1:
                self.res = min(self.res, count)
                return

            max_len = min(n - x, m - y)
            for l in range(max_len, 0, -1):
                # Check if the square can be placed
                can_place = True
                for i in range(x, x + l):
                    for j in range(y, y + l):
                        if grid[i][j]:
                            can_place = False
                            break
                    if not can_place:
                        break

                if can_place:
                    # Place the square
                    for i in range(x, x + l):
                        for j in range(y, y + l):
                            grid[i][j] = True
                    dfs(count + 1)
                    # Remove the square
                    for i in range(x, x + l):
                        for j in range(y, y + l):
                            grid[i][j] = False

        dfs(0)
        return self.res