class Solution:
    def maxSubarraySumCircular(self, nums: List[int]) -> int:
        def kadane(arr):
            max_so_far = float('-inf')
            current_max = 0
            for num in arr:
                current_max = max(num, current_max + num)
                max_so_far = max(max_so_far, current_max)
            return max_so_far

        def min_kadane(arr):
            min_so_far = float('inf')
            current_min = 0
            for num in arr:
                current_min = min(num, current_min + num)
                min_so_far = min(min_so_far, current_min)
            return min_so_far

        max_kadane_sum = kadane(nums)
        total_sum = sum(nums)
        min_kadane_sum = min_kadane(nums)

        if max_kadane_sum < 0:
            return max_kadane_sum

        circular_max_sum = total_sum - min_kadane_sum

        return max(max_kadane_sum, circular_max_sum)