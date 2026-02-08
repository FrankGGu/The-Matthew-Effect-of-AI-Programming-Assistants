class Solution:
    def findUnsortedSubarray(self, nums: List[int]) -> int:
        sorted_nums = sorted(nums)
        start, end = len(nums), 0

        for i in range(len(nums)):
            if nums[i] != sorted_nums[i]:
                start = min(start, i)
                end = max(end, i)

        return 0 if end - start < 0 else end - start + 1