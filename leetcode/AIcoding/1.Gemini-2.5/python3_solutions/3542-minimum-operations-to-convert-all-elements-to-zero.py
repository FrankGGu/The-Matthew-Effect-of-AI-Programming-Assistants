import collections

class Solution:
    def minimumOperations(self, nums: list[int]) -> int:
        unique_positives = set()
        for num in nums:
            if num > 0:
                unique_positives.add(num)
        return len(unique_positives)