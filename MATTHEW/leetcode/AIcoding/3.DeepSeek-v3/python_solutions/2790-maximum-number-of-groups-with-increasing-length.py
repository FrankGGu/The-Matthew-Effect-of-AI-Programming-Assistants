class Solution:
    def maxIncreasingGroups(self, usageLimits: List[int]) -> int:
        usageLimits.sort()
        total = 0
        res = 0
        for num in usageLimits:
            total += num
            if total >= (res + 1) * (res + 2) // 2:
                res += 1
        return res