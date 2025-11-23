class Solution:
    def reductionOperations(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        sorted_unique = sorted(count.keys())
        operations = 0
        for i in range(len(sorted_unique) - 1, 0, -1):
            operations += count[sorted_unique[i]] * (i)
        return operations