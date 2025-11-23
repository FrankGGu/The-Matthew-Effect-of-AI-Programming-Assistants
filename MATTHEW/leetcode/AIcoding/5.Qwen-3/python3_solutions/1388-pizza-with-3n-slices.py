class Solution:
    def mostSlices(self, slices: List[int]) -> int:
        from functools import lru_cache

        @lru_cache(None)
        def dp(i, j):
            if i == j:
                return slices[i]
            return max(slices[i] + dp(i + 2, j), slices[j] + dp(i, j - 2))

        return dp(0, len(slices) - 1)