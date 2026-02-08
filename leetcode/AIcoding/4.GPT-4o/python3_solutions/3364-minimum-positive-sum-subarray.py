class Solution:
    def minimumPositiveSum(self, nums: List[int]) -> int:
        total_sum = sum(x for x in nums if x > 0)
        return total_sum if total_sum > 0 else 1