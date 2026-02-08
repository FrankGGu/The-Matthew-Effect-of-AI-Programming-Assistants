class Solution:
    def uniqueMiddleMode(self, nums: List[int]) -> List[int]:
        from collections import Counter

        count = Counter(nums)
        unique_modes = [num for num, freq in count.items() if freq == 1]

        return unique_modes