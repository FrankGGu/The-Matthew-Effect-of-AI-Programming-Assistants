import math

class Solution:
    def maxScore(self, nums: List[int]) -> int:
        nums.sort(reverse=True)
        prefix = []
        current = 0
        res = 0
        for num in nums:
            current += num
            prefix.append(current)
            if current > 0:
                res += 1
            else:
                break
        return res