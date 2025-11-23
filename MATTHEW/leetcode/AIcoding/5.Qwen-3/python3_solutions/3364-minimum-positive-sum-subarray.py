class Solution:
    def minPositiveSumSubarray(self, nums):
        import sys
        min_sum = sys.maxsize
        current_sum = 0
        for num in nums:
            current_sum += num
            if current_sum > 0 and current_sum < min_sum:
                min_sum = current_sum
            if current_sum < 0:
                current_sum = 0
        return min_sum