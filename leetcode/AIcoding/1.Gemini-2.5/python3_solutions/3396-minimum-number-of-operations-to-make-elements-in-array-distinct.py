class Solution:
    def minIncrementForUnique(self, nums: list[int]) -> int:
        nums.sort()

        operations = 0
        expected_val = 0 

        for num in nums:
            if num < expected_val:
                operations += expected_val - num
                expected_val += 1
            else:
                expected_val = num + 1

        return operations