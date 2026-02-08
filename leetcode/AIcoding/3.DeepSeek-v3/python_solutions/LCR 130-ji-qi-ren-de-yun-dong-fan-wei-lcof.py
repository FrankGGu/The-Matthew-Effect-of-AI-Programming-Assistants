class Solution:
    def wardrobeFinishing(self, m: int, n: int, cnt: int) -> int:
        def sum_digits(x):
            s = 0
            while x:
                s += x % 10
                x = x // 10
            return s

        visited = [[False for _ in range(n)] for _ in range(m)]
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        count = 0

        def dfs(i, j):
            nonlocal count
            if i < 0 or i >= m or j < 0 or j >= n or visited[i][j] or (sum_digits(i) + sum_digits(j)) > cnt:
                return
            visited[i][j] = True
            count += 1
            for di, dj in directions:
                dfs(i + di, j + dj)

        dfs(0, 0)
        return count