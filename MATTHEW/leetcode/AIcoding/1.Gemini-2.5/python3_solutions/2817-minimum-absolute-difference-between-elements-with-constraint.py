import bisect

class Solution:
    def minAbsoluteDifference(self, nums: list[int], x: int) -> int:
        n = len(nums)
        min_diff = float('inf')

        candidates = [] 

        for j in range(x, n):
            bisect.insort_left(candidates, nums[j - x])

            idx = bisect.bisect_left(candidates, nums[j])

            if idx < len(candidates):
                min_diff = min(min_diff, abs(nums[j] - candidates[idx]))
                if min_diff == 0:
                    return 0

            if idx > 0:
                min_diff = min(min_diff, abs(nums[j] - candidates[idx - 1]))
                if min_diff == 0:
                    return 0

        return min_diff