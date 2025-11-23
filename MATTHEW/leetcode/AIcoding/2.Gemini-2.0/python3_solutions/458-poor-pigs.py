import math

class Solution:
    def poorPigs(self, buckets: int, minutesToDie: int, minutesToTest: int) -> int:
        if buckets == 1:
            return 0

        tests = minutesToTest // minutesToDie
        pigs = 0

        while (tests + 1) ** pigs < buckets:
            pigs += 1

        return pigs