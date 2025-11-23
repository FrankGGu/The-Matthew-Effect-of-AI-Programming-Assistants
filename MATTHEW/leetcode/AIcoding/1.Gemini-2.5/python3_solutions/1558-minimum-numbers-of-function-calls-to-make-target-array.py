class Solution:
    def minOperations(self, nums: list[int]) -> int:
        total_increments = 0
        max_doubles = 0

        for num in nums:
            total_increments += bin(num).count('1')

            if num > 0:
                max_doubles = max(max_doubles, num.bit_length() - 1)

        return total_increments + max_doubles