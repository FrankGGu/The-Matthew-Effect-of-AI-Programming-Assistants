class Solution:
    def maxScore(self, nums: List[int]) -> int:
        n = len(nums)
        max_score = 0
        current_sum = 0
        min_prefix_sum = 0

        for i in range(n):
            current_sum += nums[i]
            max_score = max(max_score, current_sum - min_prefix_sum)
            min_prefix_sum = min(min_prefix_sum, current_sum)

        return max_score