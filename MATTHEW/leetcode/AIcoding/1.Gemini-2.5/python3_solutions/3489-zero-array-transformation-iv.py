class Solution:
    def minOperations(self, nums: list[int]) -> int:
        operations = 0
        current_height = 0
        for num in nums:
            if num > current_height:
                operations += (num - current_height)
            current_height = num
        return operations