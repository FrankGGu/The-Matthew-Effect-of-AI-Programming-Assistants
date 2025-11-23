from typing import List

class Solution:
    def maximumRobots(self, batteryPercentages: List[int], cost: int) -> int
        batteryPercentages.sort()
        res = 0
        total = 0
        for b in batteryPercentages:
            total += b
            if total >= cost * (res + 1):
                res += 1
        return res