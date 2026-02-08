class Solution:
    def minOperations(self, nums: List[int]) -> int:
        operations = 0
        current_min = 0

        for num in nums:
            if num < current_min:
                current_min = num

            if num > current_min:
                operations += (num - current_min)
                current_min = num

        return operations