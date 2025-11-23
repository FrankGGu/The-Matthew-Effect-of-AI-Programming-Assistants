class Solution:
    def numWays(self, words: List[str], target: str) -> int:
        from collections import Counter
        from functools import lru_cache

        m, n = len(words[0]), len(target)
        mod = 10**9 + 7

        count = [Counter() for _ in range(m)]
        for word in words:
            for i, char in enumerate(word):
                count[i][char] += 1

        @lru_cache(None)
        def dp(i, j):
            if j == n: 
                return 1
            if i == m: 
                return 0

            total = dp(i + 1, j)
            if target[j] in count[i]:
                total += count[i][target[j]] * dp(i + 1, j + 1)
                total %= mod

            return total

        return dp(0, 0)