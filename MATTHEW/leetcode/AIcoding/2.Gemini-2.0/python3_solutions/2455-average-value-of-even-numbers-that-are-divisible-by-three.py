class Solution:
    def averageValue(self, nums: List[int]) -> int:
        filtered_nums = [num for num in nums if num % 2 == 0 and num % 3 == 0]
        if not filtered_nums:
            return 0
        return sum(filtered_nums) // len(filtered_nums)