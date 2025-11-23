class Solution:
    def minCostToRemoveElements(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        cost = 0
        for num in count:
            if count[num] > 1:
                cost += count[num] - 1
        return cost