from collections import Counter

class Solution:
    def minCost(self, basket1: list[int], basket2: list[int]) -> int:
        c1 = Counter(basket1)
        c2 = Counter(basket2)
        diff = []
        for num in c1:
            if c1[num] > c2[num]:
                diff.extend([num] * ((c1[num] - c2[num])))
        for num in c2:
            if c2[num] > c1[num]:
                diff.extend([num] * ((c2[num] - c1[num])))

        diff.sort()

        if len(diff) % 2 != 0:
            return -1

        half = len(diff) // 2

        cost = 0
        min_val = min(min(basket1), min(basket2))

        for i in range(half):
            cost += min(diff[i], 2 * min_val)

        return cost