class Solution:
    def maxAbsoluteSum(self, nums: List[int]) -> int:
        max_so_far = 0
        min_so_far = 0
        current_max = 0
        current_min = 0
        for num in nums:
            current_max = max(num, current_max + num)
            max_so_far = max(max_so_far, current_max)
            current_min = min(num, current_min + num)
            min_so_far = min(min_so_far, current_min)
        return max(abs(max_so_far), abs(min_so_far))