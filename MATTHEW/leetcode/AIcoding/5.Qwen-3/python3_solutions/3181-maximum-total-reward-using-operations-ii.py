class Solution:
    def maximumTotal(self, nums: List[int], x: int) -> int:
        from functools import lru_cache

        nums = list(set(nums))
        nums.sort()

        @lru_cache(None)
        def dfs(i, s):
            if i == len(nums):
                return s
            res = dfs(i + 1, s)
            if s + nums[i] <= x:
                res = max(res, dfs(i + 1, s + nums[i]))
            return res

        return dfs(0, 0)