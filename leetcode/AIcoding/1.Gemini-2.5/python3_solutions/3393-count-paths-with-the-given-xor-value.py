import collections

class Solution:
    def countPaths(self, grid: list[list[int]], k: int) -> int:
        m, n = len(grid), len(grid[0])

        memo1 = collections.defaultdict(lambda: collections.defaultdict(lambda: collections.defaultdict(int)))

        self.ans = 0

        total_moves = m + n - 2

        mid_moves = total_moves // 2

        def dfs1(r, c, current_xor):
            if r >= m or c >= n:
                return

            current_xor ^= grid[r][c]

            if r + c == mid_moves:
                memo1[r][c][current_xor] += 1
                return

            dfs1(r, c + 1, current_xor)
            dfs1(r + 1, c, current_xor)

        def dfs2(r, c, current_xor):
            nonlocal k, m, n

            if r < 0 or c < 0:
                return

            current_xor ^= grid[r][c]

            if r + c == mid_moves:
                target_prev_xor = k ^ current_xor ^ grid[r][c]

                if target_prev_xor in memo1[r][c]:
                    self.ans += memo1[r][c][target_prev_xor]
                return

            dfs2(r - 1, c, current_xor)
            dfs2(r, c - 1, current_xor)

        dfs1(0, 0, 0)

        dfs2(m - 1, n - 1, 0)

        return self.ans