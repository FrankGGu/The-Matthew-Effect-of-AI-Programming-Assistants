class Solution:
    def minOperations(self, nums: List[int]) -> int:
        operations = 0
        for num in nums:
            if num > 0:
                operations += num
            else:
                operations += abs(num)
        return operations