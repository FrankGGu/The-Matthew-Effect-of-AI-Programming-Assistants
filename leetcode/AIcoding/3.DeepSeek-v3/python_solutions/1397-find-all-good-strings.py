class Solution:
    def findGoodStrings(self, n: int, s1: str, s2: str, evil: str) -> int:
        mod = 10**9 + 7
        m = len(evil)

        # KMP预处理evil的失败函数
        fail = [0] * m
        for i in range(1, m):
            j = fail[i-1]
            while j > 0 and evil[i] != evil[j]:
                j = fail[j-1]
            if evil[i] == evil[j]:
                fail[i] = j + 1

        # 记忆化搜索
        from functools import lru_cache

        @lru_cache(maxsize=None)
        def dfs(pos, evil_matched, is_lower, is_higher):
            if evil_matched == m:
                return 0
            if pos == n:
                return 1

            total = 0
            low = ord(s1[pos]) if not is_lower else ord('a')
            high = ord(s2[pos]) if not is_higher else ord('z')

            for c in range(low, high + 1):
                new_evil_matched = evil_matched
                while new_evil_matched > 0 and chr(c) != evil[new_evil_matched]:
                    new_evil_matched = fail[new_evil_matched - 1]
                if chr(c) == evil[new_evil_matched]:
                    new_evil_matched += 1

                new_is_lower = is_lower or (c > low)
                new_is_higher = is_higher or (c < high)
                total += dfs(pos + 1, new_evil_matched, new_is_lower, new_is_higher)
                total %= mod

            return total

        return dfs(0, 0, False, False)