class Solution:
    def minImpossibleOR(self, nums: list[int]) -> int:
        nums.sort()

        current_or_sum = 0

        for num in nums:
            if num > current_or_sum + 1:
                return current_or_sum + 1
            else:
                current_or_sum |= num

        return current_or_sum + 1