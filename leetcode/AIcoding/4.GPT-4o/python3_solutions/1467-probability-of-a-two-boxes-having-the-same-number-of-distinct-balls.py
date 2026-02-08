from collections import Counter
from math import comb

class Solution:
    def getProbability(self, box1: List[int], box2: List[int]) -> float:
        total_balls = sum(box1) + sum(box2)
        distinct_balls = len(box1) + len(box2)

        counts1 = Counter(box1)
        counts2 = Counter(box2)

        numerator = 0
        denominator = 0

        for i in range(total_balls + 1):
            if i in counts1:
                numerator += comb(total_balls, i) * counts1[i]
            if i in counts2:
                denominator += comb(total_balls, i) * counts2[i]

        return numerator / denominator if denominator else 0.0