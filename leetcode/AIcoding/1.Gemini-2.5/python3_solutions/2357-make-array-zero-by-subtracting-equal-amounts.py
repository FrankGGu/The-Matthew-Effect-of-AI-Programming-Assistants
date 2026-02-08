class Solution:
    def minimumOperations(self, nums: list[int]) -> int:
        unique_positive_numbers = set()
        for num in nums:
            if num > 0:
                unique_positive_numbers.add(num)
        return len(unique_positive_numbers)