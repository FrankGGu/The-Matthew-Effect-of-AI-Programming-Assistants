class Solution:
    def minOperations(self, nums: List[int]) -> int:
        operations = 0
        while True:
            non_zero = [num for num in nums if num != 0]
            if not non_zero:
                break
            min_val = min(non_zero)
            operations += min_val
            nums = [num - min_val if num != 0 else 0 for num in nums]
        return operations