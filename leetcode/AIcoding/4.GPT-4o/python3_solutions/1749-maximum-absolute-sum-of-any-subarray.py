class Solution:
    def maxAbsoluteSum(self, nums: List[int]) -> int:
        max_ending_here = min_ending_here = 0
        max_sum = 0

        for num in nums:
            max_ending_here = max(num, max_ending_here + num)
            min_ending_here = min(num, min_ending_here + num)
            max_sum = max(max_sum, abs(max_ending_here), abs(min_ending_here))

        return max_sum