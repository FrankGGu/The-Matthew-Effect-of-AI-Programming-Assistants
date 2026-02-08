class Solution:
    def maxSubarraySumCircular(self, nums: List[int]) -> int:
        total = sum(nums)
        max_ending_here = max_so_far = nums[0]
        min_ending_here = min_so_far = nums[0]

        for num in nums[1:]:
            max_ending_here = max(num, max_ending_here + num)
            max_so_far = max(max_so_far, max_ending_here)
            min_ending_here = min(num, min_ending_here + num)
            min_so_far = min(min_so_far, min_ending_here)

        if max_so_far > 0:
            return max(max_so_far, total - min_so_far)
        return max_so_far