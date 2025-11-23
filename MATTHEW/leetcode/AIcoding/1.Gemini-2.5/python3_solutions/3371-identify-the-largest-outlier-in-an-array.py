from typing import List

class Solution:
    def identifyLargestOutlier(self, nums: List[int]) -> int:
        evens = []
        odds = []
        for num in nums:
            if num % 2 == 0:
                evens.append(num)
            else:
                odds.append(num)

        if len(evens) == 1:
            return evens[0]
        else:
            return odds[0]