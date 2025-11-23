class Solution:
    def minMoves(self, nums: list[int]) -> int:
        min_val = min(nums)
        total_sum = sum(nums)
        n = len(nums)
        return total_sum - n * min_val