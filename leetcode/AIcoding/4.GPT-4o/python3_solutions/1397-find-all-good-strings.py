class Solution:
    def findGoodStrings(self, n: int, s1: str, s2: str, evil: str) -> int:
        mod = 10**9 + 7
        m = len(evil)
        dp = [[[-1 for _ in range(m)] for _ in range(2)] for _ in range(n + 1)]

        def kmp():
            lps = [0] * m
            j = 0
            for i in range(1, m):
                while j > 0 and evil[i] != evil[j]:
                    j = lps[j - 1]
                if evil[i] == evil[j]:
                    j += 1
                lps[i] = j
            return lps

        lps = kmp()

        def dfs(pos, tight1, tight2, evil_index):
            if evil_index == m:
                return 0
            if pos == n:
                return 1
            if dp[pos][tight1][evil_index] != -1:
                return dp[pos][tight1][evil_index]

            res = 0
            low = s1[pos] if tight1 else 'a'
            high = s2[pos] if tight2 else 'z'

            for c in range(ord(low), ord(high) + 1):
                new_tight1 = tight1 and (c == ord(low))
                new_tight2 = tight2 and (c == ord(high))
                new_evil_index = evil_index

                while new_evil_index > 0 and chr(c) != evil[new_evil_index]:
                    new_evil_index = lps[new_evil_index - 1]
                if chr(c) == evil[new_evil_index]:
                    new_evil_index += 1

                res = (res + dfs(pos + 1, new_tight1, new_tight2, new_evil_index)) % mod

            dp[pos][tight1][evil_index] = res
            return res

        return dfs(0, 1, 1, 0)