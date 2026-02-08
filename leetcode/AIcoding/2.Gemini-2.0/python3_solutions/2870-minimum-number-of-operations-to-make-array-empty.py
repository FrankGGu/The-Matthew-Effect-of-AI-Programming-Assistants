from collections import Counter

class Solution:
    def minOperations(self, nums: list[int]) -> int:
        counts = Counter(nums)
        operations = 0
        for count in counts.values():
            if count == 1:
                return -1
            operations += (count + 2) // 3
        return operations