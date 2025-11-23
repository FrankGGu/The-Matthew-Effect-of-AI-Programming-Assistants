import bisect

class Solution:
    def minAbsoluteDifference(self, nums: List[int], x: int) -> int:
        sorted_list = []
        min_diff = float('inf')

        for i in range(len(nums)):
            if i >= x:
                bisect.insort(sorted_list, nums[i - x])
                num = nums[i]
                pos = bisect.bisect_left(sorted_list, num)
                if pos < len(sorted_list):
                    min_diff = min(min_diff, abs(sorted_list[pos] - num))
                if pos > 0:
                    min_diff = min(min_diff, abs(sorted_list[pos - 1] - num))

        return min_diff