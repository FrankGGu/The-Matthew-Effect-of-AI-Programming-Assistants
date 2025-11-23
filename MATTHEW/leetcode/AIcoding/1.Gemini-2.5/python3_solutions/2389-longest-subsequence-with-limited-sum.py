import itertools
import bisect

class Solution:
    def answerQueries(self, nums: list[int], queries: list[int]) -> list[int]:
        nums.sort()

        prefix_sums = list(itertools.accumulate(nums))

        ans = []
        for q in queries:
            idx = bisect.bisect_right(prefix_sums, q)
            ans.append(idx)

        return ans