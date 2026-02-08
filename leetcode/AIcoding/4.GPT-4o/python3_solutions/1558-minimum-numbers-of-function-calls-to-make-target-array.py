class Solution:
    def minOperations(self, nums: List[int]) -> int:
        max_num = max(nums)
        operations = 0

        while max_num > 0:
            operations += 1
            max_num //= 2

        return operations + len(nums) - 1