class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        unique_nums = set(nums)
        return len(unique_nums) if 0 not in unique_nums else len(unique_nums) - 1