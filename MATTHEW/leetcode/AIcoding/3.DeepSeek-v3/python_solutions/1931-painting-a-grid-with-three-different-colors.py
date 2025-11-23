class Solution:
    def colorTheGrid(self, m: int, n: int) -> int:
        MOD = 10**9 + 7

        def get_valid_colors(mask, pos, m):
            up = (mask >> (2 * (pos - 1))) & 3 if pos > 0 else -1
            left = (mask >> (2 * pos)) & 3 if pos < m - 1 else -1
            forbidden = set()
            if up != -1:
                forbidden.add(up)
            if left != -1:
                forbidden.add(left)
            return [c for c in range(3) if c not in forbidden]

        def dfs(pos, mask, curr_mask, m):
            if pos == m:
                return 1
            res = 0
            for c in get_valid_colors(mask, pos, m):
                res += dfs(pos + 1, mask, curr_mask | (c << (2 * pos)), m)
            return res

        from functools import lru_cache

        @lru_cache(maxsize=None)
        def dp(col, prev_mask):
            if col == n:
                return 1
            res = 0
            mask = 0
            stack = [(0, mask)]
            total = 0
            while stack:
                pos, curr_mask = stack.pop()
                if pos == m:
                    total += dp(col + 1, curr_mask)
                    continue
                for c in get_valid_colors(prev_mask, pos, m):
                    new_mask = curr_mask | (c << (2 * pos))
                    stack.append((pos + 1, new_mask))
            return total % MOD

        return dp(0, 0)