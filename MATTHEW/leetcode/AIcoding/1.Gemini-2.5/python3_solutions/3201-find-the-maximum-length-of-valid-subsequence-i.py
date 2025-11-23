class Solution:
    def maximumLength(self, nums: list[int]) -> int:
        even_count = 0
        odd_count = 0
        for num in nums:
            if num % 2 == 0:
                even_count += 1
            else:
                odd_count += 1
        return max(even_count, odd_count)