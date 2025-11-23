def maxIncreasingGroups(self, usageLimits: List[int]) -> int:
    usageLimits.sort()
    total, k = 0, 0
    while total + (k + 1) <= sum(usageLimits):
        k += 1
        total += k
    return k