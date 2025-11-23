class Solution:
    def kConcatenation(self, arr: List[int]) -> int:
        def maxSubarraySum(nums):
            max_ending_here = max_so_far = nums[0]
            for x in nums[1:]:
                max_ending_here = max(x, max_ending_here + x)
                max_so_far = max(max_so_far, max_ending_here)
            return max_so_far

        n = len(arr)
        if n == 0:
            return 0
        max_single = maxSubarraySum(arr)
        total_sum = sum(arr)
        if total_sum < 0:
            return max_single
        else:
            return max(max_single, total_sum * 2)