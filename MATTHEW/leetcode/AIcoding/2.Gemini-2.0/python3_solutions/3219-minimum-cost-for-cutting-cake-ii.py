import functools

class Solution:
    def minCost(self, cuts: list[int], length: int) -> int:
        cuts = sorted(cuts)
        cuts = [0] + cuts + [length]
        n = len(cuts)

        @functools.lru_cache(None)
        def dp(l, r):
            if r - l <= 1:
                return 0

            min_cost = float('inf')
            for i in range(l + 1, r):
                min_cost = min(min_cost, cuts[r] - cuts[l] + dp(l, i) + dp(i, r))

            return min_cost

        return dp(0, n - 1)