class Solution:
    def sumOfPowers(self, nums: List[int], k: int) -> int:
        MOD = 10**9 + 7
        nums.sort()
        n = len(nums)
        from functools import lru_cache

        @lru_cache(maxsize=None)
        def dp(i, cnt, last, min_diff):
            if cnt == k:
                return min_diff % MOD
            if i == n:
                return 0
            res = dp(i + 1, cnt, last, min_diff)
            if cnt == 0:
                new_diff = float('inf')
            else:
                new_diff = min(min_diff, nums[i] - last)
            res += dp(i + 1, cnt + 1, nums[i], new_diff)
            return res % MOD

        return dp(0, 0, 0, float('inf'))