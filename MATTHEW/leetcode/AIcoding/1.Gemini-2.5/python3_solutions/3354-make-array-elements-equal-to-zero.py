class Solution:
    def minimumOperations(self, nums: list[int]) -> int:
        positive_unique_nums = set()
        for num in nums:
            if num > 0:
                positive_unique_nums.add(num)
        return len(positive_unique_nums)