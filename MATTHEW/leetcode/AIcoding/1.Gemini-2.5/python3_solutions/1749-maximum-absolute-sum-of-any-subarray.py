class Solution:
    def maxAbsoluteSum(self, nums: list[int]) -> int:
        current_max = 0
        global_max = 0

        current_min = 0
        global_min = 0

        for num in nums:
            current_max += num
            global_max = max(global_max, current_max)
            if current_max < 0:
                current_max = 0

            current_min += num
            global_min = min(global_min, current_min)
            if current_min > 0:
                current_min = 0

        return max(global_max, -global_min)