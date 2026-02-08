from typing import List
from functools import lru_cache

class Solution:
    def stoneGameII(self, piles: List[int]) -> int:
        n = len(piles)

        suffix_sum = [0] * (n + 1)
        for i in range(n - 1, -1, -1):
            suffix_sum[i] = piles[i] + suffix_sum[i+1]

        @lru_cache(None)
        def dp(i, m):
            if i + 2 * m >= n:
                return suffix_sum[i]

            max_alice_score = 0

            for x in range(1, 2 * m + 1):
                current_alice_score = suffix_sum[i] - dp(i+x, max(m, x))
                max_alice_score = max(max_alice_score, current_alice_score)

            return max_alice_score

        return dp(0, 1)