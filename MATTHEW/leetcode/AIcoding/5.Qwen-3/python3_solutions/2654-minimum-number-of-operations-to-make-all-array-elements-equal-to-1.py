class Solution:
    def minOperations(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        if 1 in count:
            return sum(num - 1 for num in count if num != 1)
        else:
            return sum(num - 1 for num in count) + len(count) - 1