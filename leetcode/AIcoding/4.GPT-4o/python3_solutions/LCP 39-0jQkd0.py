class Solution:
    def movingCount(self, m: int, n: int, k: int) -> int:
        def digit_sum(x):
            return sum(int(d) for d in str(x))

        def dfs(x, y):
            if x < 0 or y < 0 or x >= m or y >= n or (digit_sum(x) + digit_sum(y)) > k or (x, y) in visited:
                return 0
            visited.add((x, y))
            return 1 + dfs(x + 1, y) + dfs(x, y + 1)

        visited = set()
        return dfs(0, 0)