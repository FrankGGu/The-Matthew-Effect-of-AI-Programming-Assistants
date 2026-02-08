class Solution:
    def maxPartitionsAfterOperations(self, s: str, k: int) -> int:
        n = len(s)
        from functools import lru_cache

        @lru_cache(maxsize=None)
        def dfs(pos, mask, changed):
            if pos == n:
                return 0
            new_mask = mask | (1 << (ord(s[pos]) - ord('a')))
            if bin(new_mask).count('1') > k:
                res = 1 + dfs(pos + 1, 1 << (ord(s[pos]) - ord('a')), changed)
            else:
                res = dfs(pos + 1, new_mask, changed)
            if not changed:
                for c in range(26):
                    new_mask_c = mask | (1 << c)
                    if bin(new_mask_c).count('1') > k:
                        res = max(res, 1 + dfs(pos + 1, 1 << c, True))
                    else:
                        res = max(res, dfs(pos + 1, new_mask_c, True))
            return res

        return 1 + dfs(0, 0, False)