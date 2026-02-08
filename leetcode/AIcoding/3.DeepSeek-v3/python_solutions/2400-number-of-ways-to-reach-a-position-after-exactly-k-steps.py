class Solution:
    def numberOfWays(self, startPos: int, endPos: int, k: int) -> int:
        MOD = 10**9 + 7

        @lru_cache(None)
        def dfs(pos, steps):
            if steps == 0:
                return 1 if pos == endPos else 0
            return (dfs(pos + 1, steps - 1) + dfs(pos - 1, steps - 1)) % MOD

        return dfs(startPos, k)