import math

class Solution:
    def minCuts(self, bamboo: list[int]) -> int:
        n = len(bamboo)
        total_cuts = 0
        for length in bamboo:
            if length <= 1:
                continue
            total_cuts += math.ceil(math.sqrt(length)) - 1
        return total_cuts