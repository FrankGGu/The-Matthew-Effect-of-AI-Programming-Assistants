from functools import lru_cache

class Solution:
    def maxOperations(self, nums: list[int]) -> int:
        n = len(nums)

        @lru_cache(None)
        def solve(left, right, score):
            if left >= right:
                return 0

            res = 0
            if score == -1:
                res = max(
                    1 + solve(left + 2, right, nums[left] + nums[left + 1]),
                    1 + solve(left + 1, right - 1, nums[left] + nums[right]),
                    1 + solve(left, right - 2, nums[right - 1] + nums[right]),
                )
            else:
                if left + 1 <= right and nums[left] + nums[left + 1] == score:
                    res = max(res, 1 + solve(left + 2, right, score))
                if left <= right - 1 and nums[left] + nums[right] == score:
                    res = max(res, 1 + solve(left + 1, right - 1, score))
                if left <= right - 2 and nums[right - 1] + nums[right] == score:
                    res = max(res, 1 + solve(left, right - 2, score))

            return res

        return solve(0, n - 1, -1)