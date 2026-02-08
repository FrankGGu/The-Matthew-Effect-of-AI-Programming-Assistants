class Solution:
    def findShortestSubarray(self, nums: List[int]) -> int:
        first = {}
        last = {}
        for i, num in enumerate(nums):
            if num not in first:
                first[num] = i
            last[num] = i

        degree = max(last[num] - first[num] + 1 for num in first)
        return degree