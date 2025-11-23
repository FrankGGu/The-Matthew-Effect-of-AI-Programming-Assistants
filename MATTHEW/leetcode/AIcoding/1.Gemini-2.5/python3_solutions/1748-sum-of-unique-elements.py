from collections import Counter

class Solution:
    def sumOfUnique(self, nums: list[int]) -> int:
        counts = Counter(nums)
        total_sum = 0
        for num, count in counts.items():
            if count == 1:
                total_sum += num
        return total_sum