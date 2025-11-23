from collections import defaultdict

class Solution:
    def findShortestSubArray(self, nums: list[int]) -> int:
        first = defaultdict(int)
        last = defaultdict(int)
        count = defaultdict(int)

        for i, num in enumerate(nums):
            if num not in first:
                first[num] = i
            last[num] = i
            count[num] += 1

        degree = max(count.values())
        shortest = len(nums)

        for num, freq in count.items():
            if freq == degree:
                shortest = min(shortest, last[num] - first[num] + 1)

        return shortest