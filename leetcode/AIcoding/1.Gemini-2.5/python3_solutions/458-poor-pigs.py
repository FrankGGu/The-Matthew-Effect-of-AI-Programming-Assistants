import math

class Solution:
    def poorPigs(self, buckets: int, minutesToDie: int, minutesToTest: int) -> int:

        test_rounds = minutesToTest // minutesToDie

        # Each pig can provide (test_rounds + 1) pieces of information:
        # die at round 1, die at round 2, ..., die at round test_rounds, or survive.
        states_per_pig = test_rounds + 1

        pigs = 0
        while (states_per_pig ** pigs) < buckets:
            pigs += 1

        return pigs